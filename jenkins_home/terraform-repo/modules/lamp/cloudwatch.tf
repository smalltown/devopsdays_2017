resource "aws_cloudwatch_metric_alarm" "lamp_cpu_high" {

    alarm_name = "${var.name}-cpu-util-high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "300"
    statistic = "Average"
    threshold = "70"
    alarm_description = "This metric monitors ec2 cpu for high utilization"
    alarm_actions = [
        "${aws_autoscaling_policy.lamp_scale_out.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.lamp_asg.name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "lamp_cpu_low" {

    alarm_name = "${var.name}-cpu-util-low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "300"
    statistic = "Average"
    threshold = "30"
    alarm_description = "This metric monitors ec2 cpu for low utilization"
    alarm_actions = [
        "${aws_autoscaling_policy.lamp_scale_in.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.lamp_asg.name}"
    }
}
