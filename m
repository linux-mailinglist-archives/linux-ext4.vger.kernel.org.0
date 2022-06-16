Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E1454E058
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 13:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377041AbiFPLzR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 07:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377051AbiFPLzH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 07:55:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F355F26A
        for <linux-ext4@vger.kernel.org>; Thu, 16 Jun 2022 04:54:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x4so1296999pfj.10
        for <linux-ext4@vger.kernel.org>; Thu, 16 Jun 2022 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JORvJ76YZUnXA8yViAI8KZykUORbRnZMMpR1ykLsjiU=;
        b=aGLfBwgWivL31vY1/JScz2DMlDQMlIJ+SJK9m7Qtmo3Lw2PVwdStdQZ2UHC/XSwGYs
         YCgPTDh9HJMA93VleIWo73KdapZFBVcNBfTuCerqeExg000Q7iYlW+hUNhA+mA04mfBo
         lPV204NUKwd7s8ORyDftIeNh1kzL3cRxOAisc5r5mrgnyHd8IdrEvwzjC3Xv/mEObe/u
         xVRDmziPwK6IbjAZH4eBVJr5nezxO8wcqRp5Jrmgog4jllKfbzU8phYxmu2epQxPtZwx
         r7XQV1GXyj8FS4uTcj4XXIsaXTTVrx9uU5kxBPnb++OOHO6ADeaN5+9VNvrW+TWolPHr
         caGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JORvJ76YZUnXA8yViAI8KZykUORbRnZMMpR1ykLsjiU=;
        b=UHb4mvwopNwPMBnfDcVcSDIetDMF0J38ZfQBw4fs4Ue+/eR+053gPO9Y7AbVApl5TT
         BKBHteyQP7UzbawloFr6wTcF/s3z/1Y5IeLqJtazB2ZMF2VMw2EkAEt7dOueu9PGOYV6
         LXuqnCBuamOBOr2WV/S/cVh4TuduruUrPRPrK7XAVXtJ4XurjcAOfhSzqR5PI2QMLXQN
         8Bpdo39Mqq1s1sux6xW4Q3eRS8aXzpkKy15CPpTcbNAcUnxDd1YKGicft3bXBYcgBqZW
         /UMrw2tI1wLrXpj51S5ahqxJhYlvPgvFjvZbz5dBQ1BUoTQCcBDX6VEB4urA0KlljWwF
         NKQw==
X-Gm-Message-State: AJIora8S9zR8rzA2B/siEra7+xVopG4eQ/6Z9ijSht/DmyhC2PJ5VfYk
        lvf18Gp8Y5QVfkLwRRH9vvw=
X-Google-Smtp-Source: AGRyM1t+E1j98jp+gYksBATG1mEPa3+p2smfZaAi8rT6teDRZkdMfbSaBLFMGPxbvSDU+k2+PwNPcw==
X-Received: by 2002:a05:6a00:1705:b0:51c:26ae:569c with SMTP id h5-20020a056a00170500b0051c26ae569cmr4428558pfc.28.1655380486175;
        Thu, 16 Jun 2022 04:54:46 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id c11-20020a621c0b000000b0051ba303f1c0sm1576895pfc.127.2022.06.16.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 04:54:45 -0700 (PDT)
Date:   Thu, 16 Jun 2022 17:24:40 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/10 v2] ext4: Fix possible fs corruption due to xattr
 races
Message-ID: <20220616115440.ryjyecrwprgfoxp2@riteshh-domain>
References: <20220614124146.21594-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614124146.21594-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/06/14 06:05PM, Jan Kara wrote:
> Hello,
>
> this is the second version of my patches to fix the race in ext4 xattr handling
> that led to assertion failure in jbd2 Ritesh has reported. The series is
> completely reworked. This time it passes beating with "stress-ng --xattr 16".
> Also I'm somewhat happier about the current solution because, although it is
> still not trivial to use mbcache correctly, it is at least harder to use it
> in a racy way :). Please let me know what you think about this series.

I have tested this on my setup where I was able to reproduce the problem with
stress-ng. It ran for several hours and also passed fstests (quick).

So feel free to -
Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

>
> Changes since v1:
> * Reworked the series to fix all corner cases and make API less errorprone.
>
> 								Honza
>
> Previous versions:
> Link: http://lore.kernel.org/r/20220606142215.17962-1-jack@suse.cz # v1
