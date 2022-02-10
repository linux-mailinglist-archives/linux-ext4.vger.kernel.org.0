Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287CB4B11CF
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Feb 2022 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbiBJPha (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Feb 2022 10:37:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbiBJPha (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Feb 2022 10:37:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FD11DF
        for <linux-ext4@vger.kernel.org>; Thu, 10 Feb 2022 07:37:31 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AEXVaI020239;
        Thu, 10 Feb 2022 15:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=f3B4ZvNaKIwmMO8CazSSskOkrvRDQ4idk6gBrxGOO2o=;
 b=p5PtizEuI2bKF0i0XPGxHS4Z7TdhBnOuYmGZ5a4IJocJZT+ZjhL3sclC0ka8Lab+01ye
 4lcxKINvKjWJE4d1GeIw5cX6+cs+CNCjAzSSdqMnAeLLwOIxTqYWjMebTl4iiUdHNvkk
 8O4KQj5BNZBeqYR1TJmdEcr4WAqg0b7KcGZalH4onmDJTT+iejGOO8Hj4aT1pBqqsqog
 RQrkOFZyGK/TXRp94Ek8oV7EC+NkFTKUOqMoLZDc4ITiHXBy3e3JjP1p/zYaAbebd1fH
 ffEalixicMoX8cd1aRFlrD/GCJpqOJNwWNW2kNJFzvLJt4yvIp1sQlMHWA4lE1If4/9C Eg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e4vmcnmyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 15:37:27 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21AFI2Pl019658;
        Thu, 10 Feb 2022 15:37:24 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggkhqw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 15:37:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21AFbMiL44433838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 15:37:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F5ADAE051;
        Thu, 10 Feb 2022 15:37:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3C97AE04D;
        Thu, 10 Feb 2022 15:37:21 +0000 (GMT)
Received: from localhost (unknown [9.43.74.163])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Feb 2022 15:37:21 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Ritesh Harjani <riteshh@linux.ibm.com>,
        syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
Subject: [PATCH] jbd2: Fix use-after-free of transaction_t race
Date:   Thu, 10 Feb 2022 21:07:11 +0530
Message-Id: <948c2fed518ae739db6a8f7f83f1d58b504f87d0.1644497105.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 34Ti7LGdlnW3tgCSLJyigcBhLU08e1C2
X-Proofpoint-ORIG-GUID: 34Ti7LGdlnW3tgCSLJyigcBhLU08e1C2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_07,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxlogscore=992 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2_journal_wait_updates() is called with j_state_lock held. But if
there is a commit in progress, then this transaction might get committed
and freed via jbd2_journal_commit_transaction() ->
jbd2_journal_free_transaction(), when we release j_state_lock.
So check for journal->j_running_transaction everytime we release and
acquire j_state_lock to avoid use-after-free issue.

Fixes: 4f98186848707f53 ("jbd2: refactor wait logic for transaction updates into a common function")
Reported-and-tested-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/jbd2/transaction.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 8e2f8275a253..259e00046a8b 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -842,27 +842,38 @@ EXPORT_SYMBOL(jbd2_journal_restart);
  */
 void jbd2_journal_wait_updates(journal_t *journal)
 {
-	transaction_t *commit_transaction = journal->j_running_transaction;
+	DEFINE_WAIT(wait);

-	if (!commit_transaction)
-		return;
+	while (1) {
+		/*
+		 * Note that the running transaction can get freed under us if
+		 * this transaction is getting committed in
+		 * jbd2_journal_commit_transaction() ->
+		 * jbd2_journal_free_transaction(). This can only happen when we
+		 * release j_state_lock -> schedule() -> acquire j_state_lock.
+		 * Hence we should everytime retrieve new j_running_transaction
+		 * value (after j_state_lock release acquire cycle), else it may
+		 * lead to use-after-free of old freed transaction.
+		 */
+		transaction_t *transaction = journal->j_running_transaction;

-	spin_lock(&commit_transaction->t_handle_lock);
-	while (atomic_read(&commit_transaction->t_updates)) {
-		DEFINE_WAIT(wait);
+		if (!transaction)
+			break;

+		spin_lock(&transaction->t_handle_lock);
 		prepare_to_wait(&journal->j_wait_updates, &wait,
-					TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&commit_transaction->t_updates)) {
-			spin_unlock(&commit_transaction->t_handle_lock);
-			write_unlock(&journal->j_state_lock);
-			schedule();
-			write_lock(&journal->j_state_lock);
-			spin_lock(&commit_transaction->t_handle_lock);
+				TASK_UNINTERRUPTIBLE);
+		if (!atomic_read(&transaction->t_updates)) {
+			spin_unlock(&transaction->t_handle_lock);
+			finish_wait(&journal->j_wait_updates, &wait);
+			break;
 		}
+		spin_unlock(&transaction->t_handle_lock);
+		write_unlock(&journal->j_state_lock);
+		schedule();
 		finish_wait(&journal->j_wait_updates, &wait);
+		write_lock(&journal->j_state_lock);
 	}
-	spin_unlock(&commit_transaction->t_handle_lock);
 }

 /**
@@ -877,8 +888,6 @@ void jbd2_journal_wait_updates(journal_t *journal)
  */
 void jbd2_journal_lock_updates(journal_t *journal)
 {
-	DEFINE_WAIT(wait);
-
 	jbd2_might_wait_for_commit(journal);

 	write_lock(&journal->j_state_lock);
--
2.31.1

