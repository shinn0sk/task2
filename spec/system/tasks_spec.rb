require 'rails_helper'

describe 'タスク管理機能', type: :system do #ユーザーA、ユーザーB、タスクA作成
    let(:user_a){ FactoryBot.create(:user, name:'ユーザーA', email: 'a@example.com')}
    let(:user_b){ FactoryBot.create(:user, name:'ユーザーB', email: 'b@example.com')}
    let!(:task_a){ FactoryBot.create(:task, name:'最初のタスク', user: user_a)}
    
    before do #ログイン作業
        visit login_path
        fill_in 'メールアドレス' ,with: login_user.email
        fill_in 'パスワード' ,with: login_user.password
        click_button 'ログイン'
    end

    
    
    describe '一覧表示機能' do 
        context 'ユーザーAがログイン状態' do
            let(:login_user){ user_a } #user A login
            
            it 'ユーザーAが作成したタスクが表示される' do
                expect(page).to have_content '最初のタスク' #veiw user A ok?
            end
        end
        
        context 'ユーザーBがログイン状態' do
            let(:login_user){ user_b } #user A login
            
            it 'ユーザーAが作成したタスクが表示されない' do
                expect(page).to have_no_content '最初のタスク' #task A not veiw ok?
            end
        end
    end


    

    describe '詳細表示機能' do
        context 'ユーザーAがログインしている' do
            let(:login_user){ user_a } #user A login
            
            before do
                visit task_path(task_a) #task A visit
            end
            
            it 'ユーザーAが作成したタスクの表示' do
                expect(page).to have_content '最初のタスク' #task A veiw ok?
            end
        end
    end

    describe '新規作成機能' do
        let(:login_user){ user_a } #user A login
        let(:task_name){ '新規作成テスト'}
        before do
            visit new_task_path #new page visit
            fill_in 'Name', with: task_name #task make
            click_button '投稿'#click_button
        end
        
        context '新規作成時名称有り'do
            it '正常時' do
                expect(page).to have_selector '.alert-success',text: '新規作成テスト'
            end
        end
        
        context '新規作成時名称無し'do
        let(:task_name){''}
        
            it 'エラー発生' do
                within'#error_explanation' do
                    expect(page).to have_content 'Name can\'t be blank'
                end
            end
        end
    end
end

