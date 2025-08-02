#!/bin/bash
# 这是一个Shell脚本示例文件
# 作者：软件部暑培讲义
# 日期：2025年7月31日
# 功能：演示Shell脚本的基本语法和常用功能

# ===========================================
# 1. 变量定义和使用
# ===========================================

# 定义字符串变量（注意等号两边不能有空格）
username="Linux学习者"
course_name="操作系统与Linux基础"
current_date=$(date '+%Y年%m月%d日')  # 使用命令替换获取当前日期

# 定义数字变量
student_count=25
total_hours=40

# 输出欢迎信息
echo "================================================"
echo "欢迎来到《$course_name》课程！"
echo "今天是：$current_date"
echo "当前用户：$username"
echo "预计学员数量：$student_count 人"
echo "课程总时长：$total_hours 小时"
echo "================================================"

# ===========================================
# 2. 用户输入处理
# ===========================================

# 获取用户输入
echo -n "请输入您的姓名: "
read user_input_name

echo -n "请输入您的学号: "
read student_id

echo "您好，$user_input_name（学号：$student_id）！"

# ===========================================
# 3. 条件判断
# ===========================================

echo -n "请输入您的Linux使用经验（年）: "
read experience_years

# 数值比较条件判断
if [ $experience_years -eq 0 ]; then
    echo "您是Linux新手，建议仔细学习基础命令。"
    level="初学者"
elif [ $experience_years -lt 2 ]; then
    echo "您有一些Linux基础，可以尝试更多高级功能。"
    level="初级用户"
elif [ $experience_years -lt 5 ]; then
    echo "您已经是Linux中级用户了！"
    level="中级用户"
else
    echo "您是Linux高手！欢迎分享经验。"
    level="高级用户"
fi

# ===========================================
# 4. 文件和目录操作
# ===========================================

# 定义工作目录
work_dir="./linux_practice"

# 检查目录是否存在
# TODO: 解释这里是如何判断目录是否存在的，并说明shell脚本中条件判断的语法
if [ -d "$work_dir" ]; then
    echo "目录 $work_dir 已存在"
else
    echo "创建工作目录: $work_dir"
    mkdir -p "$work_dir"
fi

# 创建一个学习记录文件
log_file="$work_dir/study_log.txt"

# 向文件写入学习记录
# TODO：解释这里是如何向文件写入内容的
cat > "$log_file" << EOF
=== Linux学习记录 ===
学员姓名: $user_input_name
学号: $student_id
经验等级: $level
学习日期: $current_date
课程名称: $course_name

学习内容：
1. Shell脚本基础语法
2. 变量定义和使用
3. 条件判断语句
4. 循环结构
5. 文件操作
EOF

echo "学习记录已保存到: $log_file"

# ===========================================
# 5. 循环结构演示
# ===========================================

echo "=== 课程章节列表 ==="

# for循环 - 遍历数组
chapters=("操作系统概述" "Linux基础" "文件系统" "权限管理" "Shell编程" "系统管理")

chapter_num=1
for chapter in "${chapters[@]}"; do
    echo "第${chapter_num}章: $chapter"
    ((chapter_num++))  # 数字自增
done

# while循环 - 倒计时示例
echo ""
echo "=== 课间休息倒计时 ==="
countdown=5
while [ $countdown -gt 0 ]; do
    echo "休息结束倒计时: $countdown 秒"
    sleep 1
    ((countdown--))
done
echo "休息结束，继续学习！"

# ===========================================
# 6. 函数定义和调用
# ===========================================

# 定义一个函数：检查系统信息
check_system_info() {
    echo "=== 系统信息检查 ==="
    echo "操作系统: $(uname -s)"
    echo "系统版本: $(uname -r)"
    echo "主机名: $(hostname)"
    echo "当前用户: $(whoami)"
    echo "当前目录: $(pwd)"
    echo "磁盘使用情况:"
    df -h | head -2  # 只显示前两行
}

# 定义一个带参数的函数：创建备份
create_backup() {
    local source_file="$1"  # 第一个参数：源文件
    local backup_dir="$2"   # 第二个参数：备份目录
    
    # 检查参数是否提供
    if [ $# -ne 2 ]; then
        echo "错误：请提供源文件和备份目录"
        echo "用法: create_backup <源文件> <备份目录>"
        return 1
    fi
    
    # 检查源文件是否存在
    if [ ! -f "$source_file" ]; then
        echo "错误：源文件 $source_file 不存在"
        return 1
    fi
    
    # 创建备份目录（如果不存在）
    mkdir -p "$backup_dir"
    
    # 生成备份文件名（添加时间戳）
    timestamp=$(date '+%Y%m%d_%H%M%S')
    backup_filename=$(basename "$source_file")
    backup_path="$backup_dir/${backup_filename}.backup_$timestamp"
    
    # 执行备份
    cp "$source_file" "$backup_path"
    echo "备份完成: $source_file -> $backup_path"
}

# 调用函数
check_system_info

# 为学习记录文件创建备份
if [ -f "$log_file" ]; then
    create_backup "$log_file" "$work_dir/backups"
fi

# ===========================================
# 7. 错误处理和退出状态
# ===========================================

# 定义一个可能出错的操作
risky_operation() {
    echo "执行一个可能失败的操作..."
    
    # 模拟一个可能失败的命令（尝试访问不存在的文件）
    cat "/nonexistent/file.txt" 2>/dev/null
    
    # 检查上一个命令的退出状态
    if [ $? -eq 0 ]; then
        echo "操作成功完成"
        return 0
    else
        echo "操作失败，但程序继续运行"
        return 1
    fi
}

# 调用可能失败的函数，并处理错误
if risky_operation; then
    echo "风险操作执行成功"
else
    echo "风险操作执行失败，已妥善处理"
fi

# ===========================================
# 8. 脚本结束
# ===========================================

echo ""
echo "=== 脚本执行完成 ==="
echo "感谢您学习Shell脚本编程！"
echo "生成的文件位于: $work_dir"
echo "您可以查看以下文件:"
ls -la "$work_dir"

# 询问是否清理临时文件
echo -n "是否要清理生成的练习文件？(y/n): "
read cleanup_choice

case $cleanup_choice in
    [Yy]|[Yy][Ee][Ss])
        echo "清理文件中..."
        rm -rf "$work_dir"
        echo "清理完成"
        ;;
    [Nn]|[Nn][Oo])
        echo "保留文件，您可以稍后手动清理"
        ;;
    *)
        echo "无效选择，保留文件"
        ;;
esac

# 脚本正常退出
exit 0
