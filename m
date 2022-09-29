Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110915EF44B
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Sep 2022 13:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiI2L2X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 07:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiI2L2X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 07:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F7014DAE2
        for <linux-ext4@vger.kernel.org>; Thu, 29 Sep 2022 04:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664450900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4GxfhUQzWAjNatHzE6mNj5r3EmwAQjHNiFbVJfquhLg=;
        b=Y9yTOrza60LeZNhbX1WDL5ASVGHqyQgTJdiYPYzzdMzUOrFqaG35MFiXILsbHP5URzmdGN
        L7XTGku1tehiAzcwp1494l51Aei622wYt+5NvkGXYrUs6zw/oOPeb5dmDmWUCGrq1tV1ut
        tdvDQuWedXefSTPf811Kh6Fl2/tgn+Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-IHnwxnDiNAWYxqiPVs1cyw-1; Thu, 29 Sep 2022 07:28:18 -0400
X-MC-Unique: IHnwxnDiNAWYxqiPVs1cyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83E293C0F224;
        Thu, 29 Sep 2022 11:28:17 +0000 (UTC)
Received: from fedora (unknown [10.40.193.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FE314EA48;
        Thu, 29 Sep 2022 11:28:16 +0000 (UTC)
Date:   Thu, 29 Sep 2022 13:28:13 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        liuzhiqiang26@huawei.com, linfeilong <linfeilong@huawei.com>
Subject: Re: [bug report] misc/fsck.c: Processes may kill other processes.
Message-ID: <20220929112813.6aqtktwaff2m7fh2@fedora>
References: <4ffe3143-fc53-7178-cf44-f3481eb96ae4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffe3143-fc53-7178-cf44-f3481eb96ae4@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 29, 2022 at 03:39:57PM +0800, zhanchengbin wrote:
> Hi Tytso,
> I find a error in misc/fsck.c, if run the fsck -N command, processes
> don't execute, just show what would be done. However, the pid whose
> value is -1 is added to the instance_list list in the execute
> function,if the kill_all function is called later, kill(-1, signum)
> is executed, Signals are sent to all processes except the number one
> process and itself. Other processes will be killed if they use the
> default signal processing function.

Hi,

indeed we'd like to avoid killing the instance that was not ran because
of noexecute. Can you try the following patch?

Thanks!
-Lukas


diff --git a/misc/fsck.c b/misc/fsck.c
index 1f6ec7d9..8fae7730 100644
--- a/misc/fsck.c
+++ b/misc/fsck.c
@@ -497,9 +497,10 @@ static int execute(const char *type, const char *device, const char *mntpt,
 	}
 
 	/* Fork and execute the correct program. */
-	if (noexecute)
+	if (noexecute) {
 		pid = -1;
-	else if ((pid = fork()) < 0) {
+		inst->flags |= FLAG_DONE;
+	} else if ((pid = fork()) < 0) {
 		perror("fork");
 		free(inst);
 		return errno;
@@ -544,6 +545,9 @@ static int kill_all(int signum)
 	struct fsck_instance *inst;
 	int	n = 0;
 
+	if (noexecute)
+		return 0;
+
 	for (inst = instance_list; inst; inst = inst->next) {
 		if (inst->flags & FLAG_DONE)
 			continue;


> 
> execute:
>     if (noexecute)
>         pid = -1;
>     inst->pid = pid;
>     // Find the end of the list, so we add the instance on at the end.
> 
> kill_all:
>     for (inst = instance_list; inst; inst = inst->next) {
>         kill(inst->pid, signum);
>     }
> 
> misc/fsck.c:
> main:
>     ->PRS
>         case 'N':
>             noexecute++;
>     for (num_devices) {
>         if (cancel_requested) {
>             ->kill_all(SIGTERM);
>         }
>         ->fsck_device
>             ->execute
>     }
> 
> (gdb) bt
> #0  execute (type=<optimized out>, type@entry=0x412cd0 "ext4",
> device=0x412b00 "/root/a.img", mntpt=<optimized out>,
> interactive=interactive@entry=1) at fsck.c:523
> #1  0x0000000000404959 in fsck_device (fs=fs@entry=0x412ac0,
> interactive=interactive@entry=1) at fsck.c:727
> #2  0x0000000000402704 in main (argc=<optimized out>, argv=<optimized out>)
> at fsck.c:1333
> (gdb) p inst->pid
> $7 = -1
> 
> regards,
> Zhan Chengbin
> 

