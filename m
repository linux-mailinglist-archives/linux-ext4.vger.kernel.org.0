Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5C27B3A8D
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Sep 2023 21:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjI2TUX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Sep 2023 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjI2TUW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Sep 2023 15:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791E01B2
        for <linux-ext4@vger.kernel.org>; Fri, 29 Sep 2023 12:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696015183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AK0CFDL5T7uf5smdAeJVddeLlc+IFiaCzDeUMbDRlA=;
        b=KOyXhhf0cvshaJKeicnvFwW6ucLoMd798QYLB7XF4210a40MyOYtzRGkE3d2AKR7ODMn8v
        3G60cpQLxXTZS6xVKl50ySf7Y9z/wHD/UUTTts791KquG+ohPkl+U14tdP8ij48gSiACMy
        r8ngI6BZGc83gQkHxxeaM+EwpB2HgtE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-jzNJI9__OKqJhj_YGePKZQ-1; Fri, 29 Sep 2023 15:19:40 -0400
X-MC-Unique: jzNJI9__OKqJhj_YGePKZQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-65afa60d118so189169076d6.0
        for <linux-ext4@vger.kernel.org>; Fri, 29 Sep 2023 12:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015179; x=1696619979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AK0CFDL5T7uf5smdAeJVddeLlc+IFiaCzDeUMbDRlA=;
        b=XCgNy1IQOJ2tEPUDM5Ly1nYQsEzBz/WM2vxTNptkvbMCVzY5W6IClt5MvUME+P3xIS
         U329mge0ZO5u5TZWj+eb0NakF+CUmUC74K9PSf9r4rI0pNiRcRYzdY2BakpFXT28+NL9
         mb9PJLQw9BopaLQvv7muLGQuQUVK1+gZuWio4tTXooHn0OJfueEGOb0X5N3pLaukAL5U
         10tCFVLKnI4kd+WSxRJGpWlhEIibi7CKZinsPGySj8LZITGE15N7lX39IaRlvMURYKfK
         UbZuLR5v2UvHcUxQVVrDmiPmOUDkAGmU3xJkX2AV+TApnqm75Aw7KoxFo8Xnn4os6H+H
         qBXA==
X-Gm-Message-State: AOJu0YxdhMH99841fizQJwR4h7NS1Z2M6kdZUYeb9pw1F4AZ1v5GL8HX
        gR72yv87sccqjjkZToUABLlikO/sg942mlo59WPlU+GgNXD4Emu7DIWM/ShOrNhJvKOJOO84Hf+
        j74Axys2wQe/FUoVE0MZneQ==
X-Received: by 2002:a0c:b346:0:b0:65a:f5e3:5ac0 with SMTP id a6-20020a0cb346000000b0065af5e35ac0mr4480289qvf.51.1696015179331;
        Fri, 29 Sep 2023 12:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBbQw+VJIUz05TTJLO7XB6wbV135/ydZi+cct0TAzzbq+hh+nrX8kaSEYuOH4tB7MMbDf1qw==
X-Received: by 2002:a0c:b346:0:b0:65a:f5e3:5ac0 with SMTP id a6-20020a0cb346000000b0065af5e35ac0mr4480279qvf.51.1696015179019;
        Fri, 29 Sep 2023 12:19:39 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id c14-20020a0ce14e000000b0065b31dfdf70sm1354970qvl.11.2023.09.29.12.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:19:38 -0700 (PDT)
Date:   Fri, 29 Sep 2023 15:19:54 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     syzbot <syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com>
Cc:     linux-ext4@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] WARNING in ext4_iomap_begin (2)
Message-ID: <ZRcjWomEnypTpDja@bfoster>
References: <0000000000005697bd05fe4aea49@google.com>
 <0000000000003a874b06067b1d4d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003a874b06067b1d4d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master 

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6830ea3a6c59..19ff9be02ea7 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -569,6 +569,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return ext4_buffered_write_iter(iocb, from);
 	}
 
+	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend,
 				    &unwritten, &dio_flags);
 	if (ret <= 0)
@@ -579,7 +580,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	 * to allocate blocks for DIO. We know the inode does not have any
 	 * inline data now because ext4_dio_supported() checked for that.
 	 */
-	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+	//ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 
 	offset = iocb->ki_pos;
 	count = ret;

