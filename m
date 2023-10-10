Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1907BFD1F
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Oct 2023 15:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjJJNRe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Oct 2023 09:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjJJNRc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Oct 2023 09:17:32 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA0CAF
        for <linux-ext4@vger.kernel.org>; Tue, 10 Oct 2023 06:17:30 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso73074221fa.0
        for <linux-ext4@vger.kernel.org>; Tue, 10 Oct 2023 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696943848; x=1697548648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj0zCJLxFxuY18T9CXGM+ChnBkFd0bFOQHJtGjdWNT8=;
        b=bMwk9ob8fr7hf3s83c0C7K6G9Kk98izMv84L02OnMJLHu8C894xUcvQLZ2sDVrrIW3
         5doSRaT24gbHcwLwFGrhTYawlNnfRgbkstpALhXXlsa4iwuFBnVoEevFzT5VUQPbhHbm
         YzvOGz3qrDTw3FLslo+FQ8a/eJWE3bipn9MpgZmz826wZFDoURniLY5yVFFWp4dpO9Jn
         lL6n5f/FcAWhNhIfYXzoxObj6yQBobBEJ1U7OV62NxQEQ43/SxW5KtCLHjxE20m8+Swy
         PPhtYU0fx011dOM+YQCyCom5Wnm14GGx6H9MRVTTuAj1KyG7N3HEJ73O2WvrbH/OebVL
         OG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696943848; x=1697548648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rj0zCJLxFxuY18T9CXGM+ChnBkFd0bFOQHJtGjdWNT8=;
        b=uH+Qq14RWzW/CLz9VKnzENcr6DZMGGj99mg18SeU0iBMVvWrRPO7yVhYdwh3+CRv+l
         3nTv8jZG1xGcGXgjYI9tQDrOpuWf3kyeBw6cpO83VIP9X5lBR/pzg9ebIb3irZN8gLAw
         QPstMRXQGAvSqPZX26mQ6CmW32UUD/QOsj1RU2pNhsqDeLaGBkB4Xz5G8++Dr9Rm1TBX
         ogtMTE0sTZ0U6NSyriGD5iuPQX5p6Gjs51vpdcXyshJasUCfdZdMVy9f+OlWGjL9Os10
         iJNaOgUQyVgVU3+mkan2sptXkcvPzsH3rWLda2hLH5Mmz7hzwW/LMGk+CfdUPyTyqNfV
         uS6w==
X-Gm-Message-State: AOJu0Yx99BVlrlM99n5qpS4i2+hdrjAaWi/4JK7CzS9Hg5Lx0nRwQkh9
        ETmsEgfgfK+0/61nyJrNmD2ZTvInN83/yWgrEIejZw==
X-Google-Smtp-Source: AGHT+IGGVlQDBhrlBJqhiIVf8wFhCZ8pGvbeyBAZQTIxQn4G76kVKajgzn/YFCNaVntfPjfr/aIqhkL2fqIzF86KIno=
X-Received: by 2002:a2e:8816:0:b0:2bc:db99:1775 with SMTP id
 x22-20020a2e8816000000b002bcdb991775mr15348520ljh.26.1696943848691; Tue, 10
 Oct 2023 06:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
 <20231009144340.418904-1-max.kellermann@ionos.com> <20231010131125.3uyfkqbcetfcqsve@quack3>
In-Reply-To: <20231010131125.3uyfkqbcetfcqsve@quack3>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 10 Oct 2023 15:17:17 +0200
Message-ID: <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
To:     Jan Kara <jack@suse.cz>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 10, 2023 at 3:11=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Thanks for the updated changelog! But as I'm looking into VFS code isn't
> this already handled by mode_strip_umask() / vfs_prepare_mode() in
> fs/namei.c? Because posix_acl_create() doesn't do anything to 'mode' for
> !IS_POSIXACL() filesystems either. So at least ext2 (where I've checked
> the mount option handling) does seem to have umask properly applied in al=
l
> the cases. But I might be missing something...

I'm not sure either. I was hoping the VFS experts could tell something
about how this API is supposed to be used and whose responsibility it
is to apply the umask. There used to be some confusion in the code, to
the point it was missing completely for O_TMPFILE. I'm still somewhat
confused. Maybe this is a chance to clear this confusion up and then
document it?

I wish there was one central place to apply the umask, and not spread
it around two (or more?) different code locations, depending on
whether there's an ACL. For my taste, that sort of policy is too error
prone for something as sensitive as umasks. After we already had the
O_TMPFILE vulnerability (which was only fixed last year, three
years(!) after I reported it).
