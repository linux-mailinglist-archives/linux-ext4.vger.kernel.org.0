Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE947D43D9
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Oct 2023 02:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjJXAS7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Oct 2023 20:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjJXASz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Oct 2023 20:18:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F7111A
        for <linux-ext4@vger.kernel.org>; Mon, 23 Oct 2023 17:18:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so5340140e87.3
        for <linux-ext4@vger.kernel.org>; Mon, 23 Oct 2023 17:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698106731; x=1698711531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iY8F6Fplz1VZOzDrso9gBBR3Wotc9sRtBic5aJbz6WE=;
        b=NFkz4IY8yN89v12HPfLxH+qlwrs2qNUsUulQ5ZRSJHMsg3pU5tq9gXsABmSrkxlrZd
         +cRzmR+NOKzFXMaXPlivzyfHFXat73apu1eFNdnDXH/Jv4LOkb2G1Qk1OMkR5mP7BlgM
         pFm3IGzM7xd1KOPF2yN8/pws6EU2LMbNoCyFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106731; x=1698711531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iY8F6Fplz1VZOzDrso9gBBR3Wotc9sRtBic5aJbz6WE=;
        b=ENedbSn0SA+i5t0bQfjQ7La2DHjT9eE2vMTRTADm1zLASS0ZuJvaOKXfGkObl534tJ
         SU6PNkl50e5VhZi8C5oPvAxPfxr8VKoESLKMuBXnDqZOPrDYN2Mzts7KvbP8j3pBnAjy
         /VqUVCTSq1iOh+K19yw2Gl7eClGsm9CX9vJB3yHBLTayjYHgB9fjGHwOX2ZGPSBlaZm7
         usR/+R0A7LhTCQ5NmQBcrhnTSWDXxuMjYYnaB94kswRuxA0/MPtF91nc+NlNSf1xBLIL
         mXTQEjm6OnDS0BuF4elGFc6hXAj6nFXLEg7LGlQ9XQYLzvyLFbS7oGZy1/LTe0GOMMS9
         oEcA==
X-Gm-Message-State: AOJu0YzgklB/zdKtUr/+na1/0p4jGZclT37xIag1KMZLI947C4MjjsdU
        F7JsSCZxGNjFY7UO21drP6sB+8vowO/jFfmUILFTeQH2
X-Google-Smtp-Source: AGHT+IEzws4P6z9znaHQXeJ5pVqfPs47Fgyq7RIb/dh1kZKoOcQlLAor7Rat9kNfufdOJx36c+FvSQ==
X-Received: by 2002:a05:6512:60f:b0:500:b63f:4db3 with SMTP id b15-20020a056512060f00b00500b63f4db3mr7481417lfe.35.1698106731174;
        Mon, 23 Oct 2023 17:18:51 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709062b4700b009ade1a4f795sm7207101ejg.168.2023.10.23.17.18.50
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 17:18:50 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso5698459a12.1
        for <linux-ext4@vger.kernel.org>; Mon, 23 Oct 2023 17:18:50 -0700 (PDT)
X-Received: by 2002:a50:d795:0:b0:53e:467c:33f1 with SMTP id
 w21-20020a50d795000000b0053e467c33f1mr8315209edi.8.1698106710154; Mon, 23 Oct
 2023 17:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area> <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
In-Reply-To: <ZTcBI2xaZz1GdMjX@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Oct 2023 14:18:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
Message-ID: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> wrote:
>
> The problem is the first read request after a modification has been
> made. That is causing relatime to see mtime > atime and triggering
> an atime update. XFS sees this, does an atime update, and in
> committing that persistent inode metadata update, it calls
> inode_maybe_inc_iversion(force = false) to check if an iversion
> update is necessary. The VFS sees I_VERSION_QUERIED, and so it bumps
> i_version and tells XFS to persist it.

Could we perhaps just have a mode where we don't increment i_version
for just atime updates?

Maybe we don't even need a mode, and could just decide that atime
updates aren't i_version updates at all?

Yes, yes, it's obviously technically a "inode modification", but does
anybody actually *want* atime updates with no actual other changes to
be version events?

Or maybe i_version can update, but callers of getattr() could have two
bits for that STATX_CHANGE_COOKIE, one for "I care about atime" and
one for others, and we'd pass that down to inode_query_version, and
we'd have a I_VERSION_QUERIED and a I_VERSION_QUERIED_STRICT, and the
"I care about atime" case ould set the strict one.

Then inode_maybe_inc_iversion() could - for atome updates - skip the
version update *unless* it sees that I_VERSION_QUERIED_STRICT bit.

Does that sound sane to people?

Because it does sound completely insane to me to say "inode changed"
and have a cache invalidation just for an atime update.

              Linus
