Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69157AFF94
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 11:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjI0JNd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjI0JNc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 05:13:32 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C557297;
        Wed, 27 Sep 2023 02:13:30 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c4b9e09521so5421974a34.3;
        Wed, 27 Sep 2023 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695806009; x=1696410809; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EiseefzOHNtXbNuZxOy1E2AG1BUXOi6I3t8WlJGIaG8=;
        b=j1N+LDqYgX6WL8Zxoy2YSEjM5ivxwEz9n0LJlc7yVlKyGHy5lCDCwDhekI2Sx/YwWz
         uVvZb504pizqQgm9ZzjiJhtM/y5eJUdAck8cXcQ6iPK1BPOscsxp+m55sHHR3Hlhk5e3
         kGCSCXAPwtgT9TAbQM3TCWzHY2o79ITRd35pHzi8cksVBxASxCfw3ZwbFTaS9TDogj7F
         wuSnd6RWpUTAOwI+67LPxl+iF1Wc//ZG76AE9zlMfE6kky3RDkN0Nvd8ZfkG3N/LYrWD
         nuuHjrc+4zopsXf5T6ckqWWLmgHXM0f5PY45ycTN0RdpxJ7a+XHDJjKRvWAa0tz8IXH0
         tZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806009; x=1696410809;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EiseefzOHNtXbNuZxOy1E2AG1BUXOi6I3t8WlJGIaG8=;
        b=hjVpkX+BSBk/ZHz6RVuDSRHvFFMaCFVOEproJ2RXWl0wdx+U0j9lf1SwkmRR1EXmnm
         TWWHNfzICLPgVAjzV+fEYvEJLTgxoSBLwJZeeBh3vG02RfnO0//YwAfjDh7kU82Wp/Ph
         kGbmW/47a12AhAjBVLoKbs+l8BYrZ7VmPNyyd3vUEUmIg76y2a9bYk9u3IoiM4k4r8rp
         nCFxIFD+sbLCciojaVP2np4sT1kDTzWLO2luQ6kwfVMHe9mF/ZIbQ8/dh9WQ+tT2vNtC
         rUO9CORUU58TytcnLzKRntnamf0qqzhZXgpfTLR7nso03nE5l2JOO1HKwj87LU+nSXPd
         vXPQ==
X-Gm-Message-State: AOJu0Yz3YlxPBDofdTizPEwZfcDzXSBqSd2K77dFtLoeMUJXKDWne1Ub
        ns3k9JswLyWywa2lHUzs3AbIdecEyJU=
X-Google-Smtp-Source: AGHT+IEgoQPlSZuEuHoIprSSsFiV+5wehZgmRH1fe1RDxFYw1tju6jM5a8nT9JRMGhHVBc0CXcbONQ==
X-Received: by 2002:a05:6358:7e84:b0:135:47e8:76e2 with SMTP id o4-20020a0563587e8400b0013547e876e2mr1420493rwn.4.1695806009336;
        Wed, 27 Sep 2023 02:13:29 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id t1-20020a63b701000000b00577f8f4df6bsm9381310pgf.18.2023.09.27.02.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:13:28 -0700 (PDT)
Date:   Wed, 27 Sep 2023 14:43:24 +0530
Message-Id: <87ttrgf07f.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ext4: extend ext4_mb_mark_context to support allocation under journal
In-Reply-To: <20230919201532.310085-5-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> Previously, ext4_mb_mark_context is only called under fast commit
> replay path, so there is no valid handle when we update block bitmap
> and group descriptor. This patch try to extend ext4_mb_mark_context
> to be used by code under journal. There are several improvement:
> 1. add "handle_t *handle" to struct ext4_mark_context to journal block
> bitmap and group descriptor update inside ext4_mb_mark_context (the
> added journal code is based on ext4_mb_mark_diskspace_used where
> ext4_mb_mark_context is going to be used.)

> 2. add EXT4_MB_BITMAP_MARKED_CHECK flag to control check if bits in block
> bitmap are already marked as allocation code under journal asserts that
> all bits to be changed are not marked before.

Maybe we can reword this to... 
Adds a flag argument to ext4_mb_mark_context() which controls
a. EXT4_MB_BITMAP_MARKED_CHECK - whether block bitmap checking is needed.
b. EXT4_MB_SYNC_UPDATE - whether dirty buffers (bitmap and group descriptor) needs sync.


> 3. add "ext4_grpblk_t changed" to struct ext4_mark_context to notify number
> of bits in block bitmap has changed.

We should remove above point 3 as there is no "struct ext4_mark_context"
in this v7 series.

>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 64 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 49 insertions(+), 15 deletions(-)


The changes looks good to me. With commit msg updated, feel free to add-

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
