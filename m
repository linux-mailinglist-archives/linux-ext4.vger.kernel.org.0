Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE4592C93
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Aug 2022 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiHOJSf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Aug 2022 05:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiHOJSY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Aug 2022 05:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 121FB22286
        for <linux-ext4@vger.kernel.org>; Mon, 15 Aug 2022 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660555103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YzEAatXqK5JK8Pdw/RfxQTXvV1F1gOUlndcdx4iLrdU=;
        b=TBkTKcAXpyd8bjrPIsYKfJ1zTgr+9xj1SOkh/ict1KCIlvstZGvQD1OjnBkNw0MHmCXuDj
        ppSJt9eonfzdurLgjgXOYrE1pAOvGCSnE7UWtEWCtSXdl/R9kP1+2+oCExDAcmBd7gBS4Y
        XQH6jTTTj7W7ZUhN4TGBLUrloCDcMmg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-508-yRbOkHIcNjaX3elHgKFjXg-1; Mon, 15 Aug 2022 05:18:21 -0400
X-MC-Unique: yRbOkHIcNjaX3elHgKFjXg-1
Received: by mail-pl1-f199.google.com with SMTP id h12-20020a170902f54c00b0016f8858ce9bso4607368plf.9
        for <linux-ext4@vger.kernel.org>; Mon, 15 Aug 2022 02:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YzEAatXqK5JK8Pdw/RfxQTXvV1F1gOUlndcdx4iLrdU=;
        b=7LROM9heA7k4rTpikWlnEkrOJMihNzgMzVDDUCvwiCKqOwcCtTgb0Vtov3OkYRqzi8
         27QcOdbooZSiyR0F9damDDwnV8OeNyxem1NUu4iulZQhXwuyoYZC8KpxaYb6G5gxt2bt
         gEqqlpMTRdLuVdJ6FZiMEbNjRA1ATg8flsIL6L/NUIhAoJXU+qAiMSMyWn6RWI2hx9H7
         rEBVr1BLC48+v0VWZ864/JLMm95/4+b35LPqAcOVHIqwlcYWzabXVaSpXQp1TA0CfzGL
         n0KSF+OyJQglYVlRBeyK0ql0lj5x3e+4imUqiMtKxg2G4UEmAt7TyovioWD0ZY8qRJ2R
         7vCw==
X-Gm-Message-State: ACgBeo2fqjAcIS5gQbXg591j7C1dL38kv6HpXcMUshYD2137k7PwHrMG
        MTWeCMChx+35EGyLCllaPD8ixGrieI28JbFmhGDipMna9JlunOuKOv1/LXYhlmxXTTFm9tAHDOD
        0E83aWB9Tn2WrHR/1cj8Ipg==
X-Received: by 2002:a63:5f86:0:b0:41c:f1:f494 with SMTP id t128-20020a635f86000000b0041c00f1f494mr13512003pgb.51.1660555100406;
        Mon, 15 Aug 2022 02:18:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4YDWquTXSOMm1jdVzubIv7EShj6C0xfymKBr/e9wAjBfj/MNhGAfZ1BvMKB3jFHoKLk6gs+w==
X-Received: by 2002:a63:5f86:0:b0:41c:f1:f494 with SMTP id t128-20020a635f86000000b0041c00f1f494mr13511990pgb.51.1660555100054;
        Mon, 15 Aug 2022 02:18:20 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d2-20020a631d02000000b0041b823d4179sm5478507pgd.22.2022.08.15.02.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:18:19 -0700 (PDT)
Date:   Mon, 15 Aug 2022 17:18:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET v2 0/3] fstests: refactor ext4-specific code
Message-ID: <20220815091814.eybgwyf4bjg6m4dx@zlang-mailbox>
References: <166007884125.3276300.15348421560641051945.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166007884125.3276300.15348421560641051945.stgit@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 09, 2022 at 02:00:41PM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> This series aims to make it so that fstests can install device mapper
> filters for external log devices.  Before we can do that, however, we
> need to change fstests to pass the device path of the jbd2 device to
> mount and mkfs.  Before we can do /that/, refactor all the ext4-specific
> code out of common/rc into a separate common/ext4 file.
> 
> v2: fix _scratch_mkfs_sized for ext4, don't clutter up the outputs
> 
> If you're going to start using this mess, you probably ought to just
> pull from my git trees, which are linked below.
> 
> This is an extraordinary way to destroy everything.  Enjoy!
> Comments and questions are, as always, welcome.

Two weeks passed, this patchset is good to me, I'd like to merge this patchset
with "[PATCH 1/1] dmerror: support external log and realtime devices" together
this week.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> --D
> 
> fstests git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-ext4-helpers
> ---
>  common/config |    4 +
>  common/ext4   |  193 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  common/rc     |  186 ++++---------------------------------------------------
>  common/xfs    |   23 +++++++
>  4 files changed, 233 insertions(+), 173 deletions(-)
>  create mode 100644 common/ext4
> 

