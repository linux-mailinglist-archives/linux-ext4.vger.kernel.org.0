Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC1264427A
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 12:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiLFLva (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 06:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiLFLv3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 06:51:29 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B4E1D30C
        for <linux-ext4@vger.kernel.org>; Tue,  6 Dec 2022 03:51:28 -0800 (PST)
Received: from dggpeml500006.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRJdT68ZqzRpF7
        for <linux-ext4@vger.kernel.org>; Tue,  6 Dec 2022 19:50:37 +0800 (CST)
Received: from [10.174.178.112] (10.174.178.112) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 19:51:26 +0800
Message-ID: <3f405e2f-b18a-f12d-7b0e-8cb031df37eb@huawei.com>
Date:   Tue, 6 Dec 2022 19:51:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, "lijinlin (A)" <lijinlin3@huawei.com>,
        <louhongxiang@huawei.com>
From:   "lihaoxiang (F)" <lihaoxiang9@huawei.com>
Subject: [PATCH] quota-nld:remove redundant description after fix
 setup_sigterm_handler()
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.112]
X-ClientProxiedBy: dggpeml500017.china.huawei.com (7.185.36.243) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the commit 06b93e5c1caf5d36d51132cb85c11a96cbdae023, it renamed the
function `use_pid_file` to `setup_sigterm_handler` and excluded to store
daemon's pid here. So we need to clean the corresponding note in time.
---
 quota_nld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/quota_nld.c b/quota_nld.c
index 82e60c2..58a62af 100644
--- a/quota_nld.c
+++ b/quota_nld.c
@@ -459,7 +459,7 @@ static void remove_pid(int signal)
 	exit(EXIT_SUCCESS);
 }

-/* Store daemon's PID into file and register its removal on SIGTERM */
+/* Register daemon's PID file removal on SIGTERM */
 static void setup_sigterm_handler(void)
 {
 	struct sigaction term_action;
-- 
2.37.0.windows.1
