Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FCE7702B6
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Aug 2023 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjHDONL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Aug 2023 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjHDOMz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Aug 2023 10:12:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA8C11B
        for <linux-ext4@vger.kernel.org>; Fri,  4 Aug 2023 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691158326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=01IdKDapYpBgS4VL1nyFpt35ymfYGMhxF/SSEYI2AfQ=;
        b=JsFqjDFG0VmtEEFhGC5nJKVTINEYCT2aQ19Nir+pAfoesDKSwyN7HznvQ/FBafU1hrXsFZ
        SfVaMt0YkW/jkUZM5GG7mAjF19QOtYRlJ4ImfeR7bepCrGCJSN9TnsmUktlRzAx33u7U9z
        tiVVgLKnDT6QBDY5xl2Rc55hncdtPF4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-xHg0O3dYOkGYsoBlL_fJGQ-1; Fri, 04 Aug 2023 10:12:05 -0400
X-MC-Unique: xHg0O3dYOkGYsoBlL_fJGQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76c562323fbso257296685a.0
        for <linux-ext4@vger.kernel.org>; Fri, 04 Aug 2023 07:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691158324; x=1691763124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01IdKDapYpBgS4VL1nyFpt35ymfYGMhxF/SSEYI2AfQ=;
        b=imu8+e4P8cuVUWZVu10g9kUx0dLJ5JIm2fM65qMWIGHQVYL64E9o7OeDDgsRxZg1Un
         OfAMGoszZ5msPBTBZ0NGwqTaJBYKPHsK2pcxu2oUGUbYk1BKt2T8xMZQeuPEUaF8aw5g
         vRqIqFrUaA85jgjSpNdaiX5FBYID6hB25T9vkhka+HhI+z0NlsJkYM6HWEnhNLQNfm53
         ZLa0sA7mou6ETPy+SHW2zWliDzo68CkHZVsY01YZ3QnZe/C8zCkSNhnMfMYS/aXkkBXA
         bw5gJ3lvLdzULdzb00eL0KUE8rhhQOeaeCJa9Bx3Lt2M25vLUsVDzuXseb6702G6GwIK
         BJFw==
X-Gm-Message-State: AOJu0YyQB6mNXsJDPt8MghrhMLuW0tbgW7tFrQQA+o/fcy2fKuq8sPtH
        Q/7WCAzVPTFQuKgGRxsGj28kHEDiGrwpkb/R5ehNWyLlQ6HO7PX6RZLRme9fSpbALMh+Se0rhdZ
        xqKo71OsseunR4r0EdgporFoq6AuASw==
X-Received: by 2002:a05:620a:19a2:b0:76c:bd05:f818 with SMTP id bm34-20020a05620a19a200b0076cbd05f818mr2475066qkb.60.1691158324308;
        Fri, 04 Aug 2023 07:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBmSm6Uw8/pAa5NVhWPCDgt51n/u/sjXq8B18JnJAT1xXAJ8c18S9jMSVZX6v4HRdLnKa56Q==
X-Received: by 2002:a05:620a:19a2:b0:76c:bd05:f818 with SMTP id bm34-20020a05620a19a200b0076cbd05f818mr2475051qkb.60.1691158324088;
        Fri, 04 Aug 2023 07:12:04 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id z2-20020ae9c102000000b00767e98535b7sm666748qki.67.2023.08.04.07.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:12:03 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:15:07 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     syzbot <syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com>
Cc:     syzkaller-bugs@googlegroups.com, linux-ext4@vger.kernel.org
Subject: Re: [syzbot] [ext4?] WARNING in ext4_file_write_iter
Message-ID: <ZM0H65+xL7aZOtK3@bfoster>
References: <0000000000007faf0005fe4f14b9@google.com>
 <000000000000a3f45805ffcbb21f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a3f45805ffcbb21f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c457c8517f0f..5642a3466c5d 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -504,9 +504,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 	 * non-overwrite or extending, so drain all outstanding dio and set the
 	 * force wait dio flag.
 	 */
-	if (*ilock_shared && unaligned_io) {
-		*dio_flags = IOMAP_DIO_OVERWRITE_ONLY;
-	} else if (!*ilock_shared && (unaligned_io || *extend)) {
+	if (!*ilock_shared && (unaligned_io || *extend)) {
 		if (iocb->ki_flags & IOCB_NOWAIT) {
 			ret = -EAGAIN;
 			goto out;
@@ -608,7 +606,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
 			   dio_flags, NULL, 0);
-	WARN_ON_ONCE(ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT));
 	if (ret == -ENOTBLK)
 		ret = 0;
 

