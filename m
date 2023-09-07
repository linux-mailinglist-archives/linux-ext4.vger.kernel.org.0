Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC997974E5
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Sep 2023 17:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjIGPmA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Sep 2023 11:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345344AbjIGPf3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Sep 2023 11:35:29 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6592CF;
        Thu,  7 Sep 2023 08:35:06 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-64a0176b1easo6252116d6.3;
        Thu, 07 Sep 2023 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100900; x=1694705700; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=urjDqpz6JCoVdXTCwnSCnDwjuGCc92hRjBH5AnvNVH0=;
        b=mnuwwGz2URgktyAmiN4wYjmBXfLhzd3xWnH+EtMtKbHGEntqjlZYSEXi27G4cTM/o6
         d2i2eTRAmoS2wLwv1aRON+x1ZLX7AwF2weWMq0lgaBlexW48LJ8eZc75rio2FQkQ/J8G
         QIc1+/W4kaKtbh2pOGhkHeP2aJayQCYGmJOgqNJhdkGT5Bp8xgq9MpT0KpC1W7SCvrdf
         5nvfzrEKcsg6LZZfVhisLdDpBDN/o/y99FPgS9nlwD4GqeIYssg/oMDuk5rNpPXr/wWV
         28Ry4jTR6vJrc0QGMsRlYhML22XOe3uwFdu8kadeeTk8L4OMYDULdbjNBbZMH65FhjqY
         wxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100900; x=1694705700;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=urjDqpz6JCoVdXTCwnSCnDwjuGCc92hRjBH5AnvNVH0=;
        b=IryToAciffmRNBFrfrBvu2Cb4yhUNLTytHQ1YMceSScJFc/4CJOSxuPxSTWkranUCk
         Ioil0WvtJqFmQC3jt3S/jtpnukZr6gPgzEIpU29eFnPH6v/AAtsaA+hVdVcK0yiSldlv
         IxsUKcELAhBHSywkBJTQYMxv3IOfQT8c9G67YO1bwFZM4uOvs+ceBdBP5GwpAbbdcVM0
         c3x/pN8LUxywC8SIWt/GNSxeW169wXRlYIA8txmZuzvAaWONtkShwcIC2hzs3z/zSLLe
         mD8yxJYopq6vZA+uN5i+Lx6OEnowIQpYwC+oMgNf8h4wsUpcqNdErXn2vXMB9IcjTGLt
         SQ1g==
X-Gm-Message-State: AOJu0Yycy89D9C8Ctll9s+APqfkGxPIPwOdP1vvDkcHv1SbC2F0r5Gjb
        txWZI3eZYUkS5Jl1mfazgidQHlYQcdg=
X-Google-Smtp-Source: AGHT+IERPfSLD6z/hrsGzfaFdF27geuZZvH21GXJbPEkTHeARJYKwphV4IEmCtpatJ5OII53dYfvZQ==
X-Received: by 2002:a17:902:b490:b0:1c1:e52e:49e3 with SMTP id y16-20020a170902b49000b001c1e52e49e3mr15980676plr.36.1694098790523;
        Thu, 07 Sep 2023 07:59:50 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902e54b00b001ba066c589dsm12850300plf.137.2023.09.07.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 07:59:49 -0700 (PDT)
Date:   Thu, 07 Sep 2023 20:29:45 +0530
Message-Id: <87o7ie2fmm.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@kernel.org>,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery test fails
In-Reply-To: <ZPnbHhUDkmUQ5906@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Sep 07, 2023 at 07:05:38PM +0530, Ritesh Harjani wrote:
>> Thanks Matthew for proposing the final changes using folio.
>> (there were just some minor change required for fs/reiserfs/ for unused variables)
>> Pasting the final patch below (you as the author with my Signed-off-by &
>> Tested-by), which I have tested it on my system with "ext4/1k -g auto"
>
> I'd rather split that patch up a bit -- I don't think the reiserfs
> part fixes any actual problem.  I've pushed out
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/bh-fixes
>
> or git clone git://git.infradead.org/users/willy/pagecache.git
>
> I credited you as the author on the second two since I just tidied up
> your proposed fixes.
>
> I've also checked ocfs2 as the other user of JBD2 and I don't see any
> problems there.

Thanks Matthew! :) 

-ritesh 
