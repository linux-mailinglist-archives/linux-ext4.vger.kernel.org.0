Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942BB3A43B0
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jun 2021 16:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFKOEq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Jun 2021 10:04:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:27938 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229985AbhFKOEq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 11 Jun 2021 10:04:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15BDwEqA009169;
        Fri, 11 Jun 2021 07:02:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=proofpoint20171006; bh=BOHgQ738nNrsUTcgCSy77a+PHEz+6TX4nAeMwrBanuw=;
 b=F7djrjbrckEa46EFdEaWKandAlgHZyGQ8MCFHh6V/fXJwIkEtq6+dRGj8QnBv9tWzwhb
 0TW/iR660xWh3AqrmXFvmZ1NLIDU3BCaAR0GHM6a5L2q6v7vu6mI2dimsvwQJo3/h2EJ
 xy2feus5i/h+V2bXzyyOtr56BOOFZdN189DEQbbe8MeomNAqtSsLwYKjlZ5MOG36w8Cu
 dot6wul2i1iDUElI/LO+NxHj3+VC44mBQjg7ocWhe61ZbI0Dv8gABkA23HJBUg5KrnrB
 cyQOd2/niTAusk34Sto6g/g5iesk6j3kceOGJOf4NI4OM0HZndeFeAZh/4C4V1m1zTeI 1Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-002c1b01.pphosted.com with ESMTP id 393mqmafv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 07:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+/6tbZMh4SVRaTYd9u7hNfZoPYcuCali7FIv/kYNjfDabVbU2eSb2g2b765aOTb48f5OSiRzAK8D+r0qRI0Tl1BrKufvWwcYWxS//667y6OwAwFKHsw/mVpWaT0edTuMrHBkNx2F7yfPBjRffhJK1jQtT8yOq2KCHJMcAlCJUD0p3LSlHUomb20Tk7dJHU9h1VDlmp+XprD1emxnzRl+meBptbYNSuS/Ss/XhVcoXzJtGF0l8CYWF+KpHjku1rChtERD2oBHvcYIVLa2Nqyp0fcNndwjybzbzUiW/orPWfCGVf1SSvwE0GRXt6nCCnmfP4JKCF5AE0vWODas4Ywkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOHgQ738nNrsUTcgCSy77a+PHEz+6TX4nAeMwrBanuw=;
 b=UWX4NbeyfxT7HpRnI4hnM6uhX0ArH5ExdH08Zrv4NGznsHVbh/3U7BmSU4ycDFoJfPE5IXBfK125ETl+Vy9HbbVz7iD8L9oyIMtsB84ltOBgD1+DCeiLmXRLVUjQNvkBR+7Ta8HNjy9NF8UCggzAdObv9ihoaebYRIdK6lTp+vFm5/SvPNELjTYwJ3NhnVg8emf/HbXiOV2qweS+PnxciMrNLyAIfvJidY54yNi5nNo4aJLLnpwRABMDqYVrd8ECfaCTQIxhtOmLi4k9Oyiib9MyN2kI739n+F87FgY4ni12jWlzDXiMkELkmSmXdjU22q7Qci+7JR6dm6amlXt9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Authentication-Results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=nutanix.com;
Received: from CH0PR02MB7964.namprd02.prod.outlook.com (2603:10b6:610:105::16)
 by CH0PR02MB7947.namprd02.prod.outlook.com (2603:10b6:610:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 14:02:35 +0000
Received: from CH0PR02MB7964.namprd02.prod.outlook.com
 ([fe80::f833:4420:8225:5d12]) by CH0PR02MB7964.namprd02.prod.outlook.com
 ([fe80::f833:4420:8225:5d12%7]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 14:02:35 +0000
From:   Jonathan Davies <jonathan.davies@nutanix.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jonathan Davies <jonathan.davies@nutanix.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: notify sysfs on errors_count value change
Date:   Fri, 11 Jun 2021 14:02:08 +0000
Message-Id: <20210611140209.28903-1-jonathan.davies@nutanix.com>
X-Mailer: git-send-email 2.9.3
Content-Type: text/plain
X-Originating-IP: [192.146.154.247]
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To CH0PR02MB7964.namprd02.prod.outlook.com
 (2603:10b6:610:105::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nutanix.com (192.146.154.247) by SJ0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:a03:2ef::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 14:02:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fdcb364-da79-410b-186d-08d92ce19040
X-MS-TrafficTypeDiagnostic: CH0PR02MB7947:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR02MB7947BD653AA1C7FF3106E885CB349@CH0PR02MB7947.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:439;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgHk1ms0pPOoLaHXx0DnV6VpIEa5z70SVhocyoEqzwFobLyVYZacVy/iGaPUpjJsZ2RjtLGTCaVTBpuMn5DN1di+458YPnzopJ+NL8A4c9/IBJ0L3j9O3aAZf+z+6MxVyxYkAHCIktZMriXIGdUZQYQlhJWIfq2ozxfa1zbVW8BC8gIaPImn+VoFD1prdMkeJGoyXonPi+S/C9BeyKGnVYnWdFE4bnGa87sDt1EBTc3nuFN2gAyFzCHCZ97/2d2AKBbNtB/ly3Q3m9echZTQ4R7M3hG12SxCH+I3+nXRZO0U0z6ItyYamy0bSMV9izuY8w28mDWHNeqqvL8jUeEqEC70fxdROHo9G3oN4LvimWobe0fywluwPJzrS+eS3iNPbim8dTWW2o/6mB0AdRI7Cu4LBjsguDxQcKec0xP/yehEVc2YYnWN5Aea4PvqsLOAs8xTwqSjTyt1aJSdMPTDznljz8WGFoTNgwYZinwxUIoPTrTnSxjb4U8gfhS62kfnAAFJylHDvYO82RPJkHBJE8y7RPmAIeaBFTHMIwUSvvGRBRr4HyRFBqF+t+NedWSKlesWFcVaeOf1T1bch8EgzQCWACUiv/gBFoueq4FbGR8pWE7pu1p5Od08hcWAimxj/50wBS4eGeaz9qdabJaisuwLRwEN72TePzbS03MsdpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7964.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(396003)(376002)(38100700002)(36756003)(38350700002)(7696005)(52116002)(2616005)(956004)(44832011)(5660300002)(316002)(6916009)(1076003)(26005)(4326008)(186003)(54906003)(16526019)(6666004)(8886007)(83380400001)(66556008)(478600001)(66476007)(8676002)(8936002)(55016002)(2906002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 197byX+bHbPZ+u+gjeg+7AcdJsiWAw1Z+8ldznNolJaGVNJTWN7VDYZOwhu0eUKUM6F0yMaU5mCZ+O1kyWjYFbWq4qU7zCtArEqKgbynIvtCEhQbOWtTN4E8Ee8Evs0p9qJSJGN4xfiFVU+XbLf8M4t9fMyRopTZfdJ5hBAbVrwPpaZfOmHqboL7m+PWbTt9+3dqf77KV6wWM1LzHQv4e8Jjn4rufWIbb8GA5g03co/zdJu/FqDJ+2xAOpw4UM97O8FUpmR1SNRy0n09z46LNnCCKnrAppQk598PsX+n4lb9TOJUHlsO0rYrsLfB+9j18jX7rq2eBks9subcX9V682FSdiJIbFfUOI1sDx8/+x6iZx6/UzR/g2RSMxitlolpzEQXCttYTTY8fpOywGSRX24rnTqTDltgjtHxjEfVPKD4+X1DT4wVSu0hiVPqz+JSie+7oRDc82SkseEyibgiEGRczy87+raH/yYWBNat974cK7is77IK3A2riHHFj1qB2dzhYBlSzbVlQEABi24npb5wsYA05vo1Y96OVkNID26FhSeHzzhL5Akm3SnA+i3tu0cx8XNP9Jpy3G42NRK29yyU2XN9Gs6dj56jDLUX+DPbwRQ+cxJ1IEPFCRwoPQTChn6GjzpHrNYkXgBoDiyyf3Rs+BufCmPBEV2sEvtyv7MdG5nGm51q2J50DF4PilzgNWQ1cY5C60obJb2AjwhJMNv/KTaWyO/vOASCAsQRZN23UahUuY8ExRMnrC1upHNB
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdcb364-da79-410b-186d-08d92ce19040
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7964.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 14:02:35.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +J5FNypLfQN+7CnxNpo9WIkR/5AOxKRgo/+NSMU+fl/M8K/jzYMsc9OmOOTP6J6oxSRzStodKjWvty75ZqyJlNSvmv3sfSf/aIioeOef+CI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7947
X-Proofpoint-GUID: BeQqt32GL1E5LBqDOlvj5mz0UK2qXWsa
X-Proofpoint-ORIG-GUID: BeQqt32GL1E5LBqDOlvj5mz0UK2qXWsa
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-11_05:2021-06-11,2021-06-11 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After s_error_count is incremented, signal the change in the
corresponding sysfs attribute via sysfs_notify. This allows userspace to
poll() on changes to /sys/fs/ext4/*/errors_count.

Signed-off-by: Jonathan Davies <jonathan.davies@nutanix.com>
---
 fs/ext4/ext4.h  | 1 +
 fs/ext4/super.c | 1 +
 fs/ext4/sysfs.c | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 37002663..f313f5be 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3614,6 +3614,7 @@ extern const struct inode_operations ext4_symlink_inode_operations;
 extern const struct inode_operations ext4_fast_symlink_inode_operations;
 
 /* sysfs.c */
+extern void ext4_notify_error_sysfs(struct super_block *sb);
 extern int ext4_register_sysfs(struct super_block *sb);
 extern void ext4_unregister_sysfs(struct super_block *sb);
 extern int __init ext4_init_sysfs(void);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d29f6aa..2525239 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5579,6 +5579,7 @@ static void ext4_update_super(struct super_block *sb)
 		if (!es->s_error_count)
 			mod_timer(&sbi->s_err_report, jiffies + 24*60*60*HZ);
 		le32_add_cpu(&es->s_error_count, sbi->s_add_error_count);
+		ext4_notify_error_sysfs(sb);
 		sbi->s_add_error_count = 0;
 	}
 	spin_unlock(&sbi->s_error_lock);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 55fcab6..254b7fc 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -506,6 +506,13 @@ static struct kobj_type ext4_feat_ktype = {
 	.release	= (void (*)(struct kobject *))kfree,
 };
 
+void ext4_notify_error_sysfs(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
+}
+
 static struct kobject *ext4_root;
 
 static struct kobject *ext4_feat;
-- 
2.9.3

