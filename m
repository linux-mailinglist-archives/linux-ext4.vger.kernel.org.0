Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447337B389B
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Sep 2023 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjI2RZn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Sep 2023 13:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjI2RZm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Sep 2023 13:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E07219F
        for <linux-ext4@vger.kernel.org>; Fri, 29 Sep 2023 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696008295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUz+kF8Pedp7t3BD5RZV/Kj+gKF1bVi7dZrt5sygFuw=;
        b=Z++OBankya8wTalneonlYZCuz5QA9IFiU3P08O/Q0/8e7rrCr2thpS+wUGrt3rtr6POOMz
        CW633yD4A16yd3EkH2gy/rx2TW+ExyErDgMirtuvclVA1zB/NZWQqz7eAH0PNj/FdeU7Uq
        /ZMfcA+LIWkDwFM1XPLLexIz848YqB0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-64Qgg6aSOcS18hEWA1bRmg-1; Fri, 29 Sep 2023 13:24:54 -0400
X-MC-Unique: 64Qgg6aSOcS18hEWA1bRmg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-65af7b636easo195414166d6.0
        for <linux-ext4@vger.kernel.org>; Fri, 29 Sep 2023 10:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008294; x=1696613094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUz+kF8Pedp7t3BD5RZV/Kj+gKF1bVi7dZrt5sygFuw=;
        b=nZ2Shkr7EtFku/PjBzw7IeJeTeQ9hnljlb+Rlap1QNfeoTvopoYRYQJl1YAgeR8Rdr
         bgt/UKVu0X1wwrF/573CDE0/xuXOY+c97Q2dd7IhJIioNNk5pPYuB9oGN9L1NakQ7jEw
         0ReV9N0kXwJSTo4/GsGTrOeElOgVO3c9hG0/hcLBuLOWDOlpbOfqnDm4nweZdZ1Py9xs
         +PDd+cVOiO8o69WOvm18NvIM9y6WmirqMRZu1XCI4XOhlEFxD+sqZLFIPrXE2kXzqqCD
         jS1IebHK5DbGlls0zK7aJ38K6xq+IOjFwdIH0Iq3Lo0p+5jeW463RE0Rp+I5KLnZglnC
         Jv1w==
X-Gm-Message-State: AOJu0YypDsOz/fstgZnISgbjVW46kiNfNDKcbTLSQAtU00s69k+l6d5g
        70dY7f0GU75RW9q4kixECVDDdumsNx3Adii1K61PRB8PXnDxnakpC2/nxJZEB7tVomL+xQq34fW
        qr4qltBr8GmEfQ4zEJzUVnA==
X-Received: by 2002:a05:6214:3381:b0:65d:179:44ef with SMTP id mv1-20020a056214338100b0065d017944efmr5303007qvb.33.1696008293879;
        Fri, 29 Sep 2023 10:24:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlS4YZojcljVaJ9hoYK4PG2YrGotOeZeG2+jkg+EgNRJBV59aMR9u5neA++UVskqfh2Kkuqw==
X-Received: by 2002:a05:6214:3381:b0:65d:179:44ef with SMTP id mv1-20020a056214338100b0065d017944efmr5302994qvb.33.1696008293641;
        Fri, 29 Sep 2023 10:24:53 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id a14-20020a0cca8e000000b0065af71585b5sm2750585qvk.58.2023.09.29.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:24:53 -0700 (PDT)
Date:   Fri, 29 Sep 2023 13:25:08 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     syzbot <syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com>
Cc:     linux-ext4@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] WARNING in ext4_iomap_begin (2)
Message-ID: <ZRcIdBOnpNyCQ4qh@bfoster>
References: <0000000000005697bd05fe4aea49@google.com>
 <0000000000003a874b06067b1d4d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003a874b06067b1d4d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6830ea3a6c59..cad659c2e9cc 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -537,6 +537,9 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	bool ilock_shared = true;
 	int dio_flags = 0;
 
+	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
+		ilock_shared = false;
+
 	/*
 	 * Quick check here without any i_rwsem lock to see if it is extending
 	 * IO. A more reliable check is done in ext4_dio_write_checks() with

