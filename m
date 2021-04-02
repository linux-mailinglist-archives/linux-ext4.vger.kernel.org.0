Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A43525BA
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 05:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhDBDlx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 1 Apr 2021 23:41:53 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:47168 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhDBDlx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 23:41:53 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Apr 2021 23:41:53 EDT
Received: from SZ11126892 (unknown [58.251.74.232])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id 7AB49380365;
        Fri,  2 Apr 2021 11:32:37 +0800 (CST)
From:   <changfengnan@vivo.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
References: <20210329035800.648-1-changfengnan@vivo.com>
In-Reply-To: <20210329035800.648-1-changfengnan@vivo.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBleHQ0OiBmaXggZXJyb3IgY29kZSBpbiBleHQ0X2M=?=
        =?gb2312?B?b21taXRfc3VwZXI=?=
Date:   Fri, 2 Apr 2021 11:32:35 +0800
Message-ID: <000801d72770$d3f4b890$7bde29b0$@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKGikBhgiQAULD/1R54Z6dLmieg46lBzKFQ
Content-Language: zh-cn
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHR9DQ0JCSB0eTR8eVkpNSkxISE9ITkxNQkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NFE6Cxw*Qz8NPCorPSkYGig5
        OEkaCRNVSlVKTUpMSEhPSE5MQk9NVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSElZV1kIAVlBSUlOSzcG
X-HM-Tid: 0a7890a3ce66d994kuws7ab49380365
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Is there any problem with this patch? I did not see a reply, please let me
know if there is a problem. Thanks

-----邮件原件-----
发件人: Fengnan Chang <changfengnan@vivo.com> 
发送时间: 2021年3月29日 11:58
收件人: tytso@mit.edu; adilger.kernel@dilger.ca; linux-ext4@vger.kernel.org
抄送: Fengnan Chang <changfengnan@vivo.com>
主题: [PATCH] ext4: fix error code in ext4_commit_super

We should set the error code when ext4_commit_super check argument failed.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c index
03373471131c..5440b8ff86a8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5501,7 +5501,7 @@ static int ext4_commit_super(struct super_block *sb,
int sync)
 	int error = 0;

 	if (!sbh || block_device_ejected(sb))
-		return error;
+		return -EINVAL;

 	/*
 	 * If the file system is mounted read-only, don't update the
--
2.29.0



