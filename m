Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1AF6795C3
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Jan 2023 11:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjAXKwK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Jan 2023 05:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjAXKwJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Jan 2023 05:52:09 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD01449E
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 02:52:07 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id f8so7245877ilj.5
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 02:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PZZkl0nuhDOnpS6mpTFr8PbXxlSJ2XVVn7nhNW4knVE=;
        b=eysX+ECnIsH4FMjfUYT/LQAt9n6rglG6tqxiFcoAUICMiQfGdw6uRCYzxropjiIHWX
         aGm0Ai3CVpIR3vF+EduIDOySpa/9Cs7/A0TdpklPuDWKFUgQZpGb/QUx7y/gmG1+gJQT
         R0EgI2WlD8RTdP4mKPBp2BIR3O5cm0XeN7nPZ0SG8//AUcx383pwBNqlJlupg5yLuFLh
         /Bt4ywpI6JPeuzM6XnPuB0hUMriFJgSFDg1wnWsB4yXnlV+fcImKNZFnp8e56Zo2rLxF
         LM6SKfI/YCy26+jyb1ULwBcIRsTXvzHOZMkpI89Kjz5MQ29Qw33zMIR8Bf4V25RxB/nC
         pH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZZkl0nuhDOnpS6mpTFr8PbXxlSJ2XVVn7nhNW4knVE=;
        b=PRedLsBaqEahjwFwcA+xMv4/AZXhuvbG3O7QYOMpebLs/9lFn+W/M/T31B1tv5Vi7K
         NOs4rTCRVEiUWYhnIZvlB/Jbst1YPGxMGwEOM1ZdpkhaZfvPE3STFbUSsd2/Qi986eCS
         kVS8MkpHyaMBCnZ/pxUlzRNG645CAMS1s9GW+XuQBb45G3KYwqZlieWzvrQnOCrvm33b
         u1bdh13dSx94IUjrT7YDfS4sbn/FbDxO51TN2Q5Uu0cXLERKqt/JmtvEzPlDzwaIlJBe
         kdgKwPQZ269cFWXmoJkpxfPZMG2bfdqprL2sdNN/yxvcQVVlZtabSamRTviN0Dd185Ag
         KqHA==
X-Gm-Message-State: AFqh2kp7/JOacgIRMDZFvkBx7Iqndp/wFZ0ncTtsKkFdK49A+5HZEXST
        a2/tO0DcSEXhQL4gIEYmS9rNaivI6UGviVuQn+tFsA==
X-Google-Smtp-Source: AMrXdXs9ga503SwE+09dmDEVZS1/XV2RvPbDoA7tJR1Y92okF1PYzLfNb1qZ9UTKSZ00MIBxwWsvnEHJ4Bii4h03Zso=
X-Received: by 2002:a05:6e02:88d:b0:30f:5d21:e56 with SMTP id
 z13-20020a056e02088d00b0030f5d210e56mr1230055ils.192.1674557526609; Tue, 24
 Jan 2023 02:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20221121112134.407362-1-glider@google.com> <20221121112134.407362-4-glider@google.com>
In-Reply-To: <20221121112134.407362-4-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 24 Jan 2023 11:51:30 +0100
Message-ID: <CAG_fn=WDjw1MVYhEh7K4HOpGNBWsq6YuyG6Xx7XcP4Xpu+KhZg@mail.gmail.com>
Subject: Re: [PATCH 4/5] fs: hfs: initialize fsdata in hfs_file_truncate()
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 21, 2022 at 12:21 PM Alexander Potapenko <glider@google.com> wrote:
>
> When aops->write_begin() does not initialize fsdata, KMSAN may report
> an error passing the latter to aops->write_end().
>
> Fix this by unconditionally initializing fsdata.
>
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Alexander Potapenko <glider@google.com>

Dear FS maintainers,

HFS/HFSPLUS are orphaned, can someone take this patch to their tree?
Thanks in advance!
(same for "fs: hfsplus: initialize fsdata in hfsplus_file_truncate()":
https://lore.kernel.org/all/20221121112134.407362-5-glider@google.com/)
