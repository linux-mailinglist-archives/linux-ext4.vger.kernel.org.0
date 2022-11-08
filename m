Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8896620BC7
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 10:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiKHJJT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 04:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKHJJS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 04:09:18 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0C517E31
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 01:09:14 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-36a4b86a0abso128022947b3.7
        for <linux-ext4@vger.kernel.org>; Tue, 08 Nov 2022 01:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0/mSgd3/KZGrXlWsE1BO75aHYjWXnPANqXO30jlvy0o=;
        b=H1EigSh4jOLThRSpHnq9dcIPvYq1a+cJg60eKWX0jxMGiEoZ0mo+2o5tl/OIMQUMIR
         rilQK60Pz5yFli/andC57hJq6+PZvFQe5qFkMWEOMDd7ZrvCE8f6Mt4oFlrDbcZItgH9
         XgzcLaEbWSxRmR2pOqH3glvWxtnOC0ClHmtmaoQwylDKc1I3EPLIJGdH9p5RJL6ygn3Z
         8NWD8wGJyjDvU6qqlEcHl1e5E1xBLpadx/eUBbFR+hIAHfKE0bA8DNDQV45riUVRCPig
         xIc5gq/GdP0/7jbVk8yIZ8gGW2LGv5fbv4CiqkHkdaE7bPwxWaPUiId9bpfxbX9vAKzc
         +lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/mSgd3/KZGrXlWsE1BO75aHYjWXnPANqXO30jlvy0o=;
        b=TKGxP9ZA6O+6aNYHSw7nFZOmWLMRVEUOwLi2/c9tW/o2y+ZQEZCnTHdkrK5y+g7yP3
         7izW94U/QWgwNgFiPGAdYEBGxuMu3Rw4iAWanxzo4zJl/fFYJ8O/jz8afwKid2zKQUu4
         JTsB+ZwBA5JOLSqPBn0cg5dMLu4vx/XFG3h/NASQKDD6lHxHgUDc+IlA38LbKVLuwrg2
         st5fQ6niTa0ZnC0YoTdLnAMbbART81Ly/0O52h9R9hqBr5Dqem8hwqf+I4dIYTOVzOWA
         TbnvqggO99tWAVbkAlCHC9eBVCuEVh8h+gaPDzX+cGW7IF83aw5wyMmwQOoryjt94Q9q
         emBw==
X-Gm-Message-State: ACrzQf3EsBNeQY0Q9q4zndcGWOuPuDEmEsqLr8TmHEmWsayujHrG9Z6A
        ENfMnckQiQxJmJwd84J6yPddbQGvUdhV22WWqOUI0g==
X-Google-Smtp-Source: AMsMyM4RQNU9stUJYhb4ZQLjB3gwRGc8RPODKXAWT5OzpvKnNsmrRhh9YG160heTdWtV/rSGnxwnNWI6zaktjNvEz7Q=
X-Received: by 2002:a81:4811:0:b0:368:e6a7:6b38 with SMTP id
 v17-20020a814811000000b00368e6a76b38mr51888756ywa.20.1667898553086; Tue, 08
 Nov 2022 01:09:13 -0800 (PST)
MIME-Version: 1.0
References: <00000000000058d01705ecddccb0@google.com> <CAG_fn=WAyOc+1GEC+P3PpTM2zLcLcepAX1pPXkj5C6aPyrDVUA@mail.gmail.com>
 <Y2lGu/QTIWNpzFI3@sol.localdomain> <CAG_fn=VQBv-sgPhT0gLVChAtMNx0F3RcQYDKdvhBL4mBpiDkFA@mail.gmail.com>
In-Reply-To: <CAG_fn=VQBv-sgPhT0gLVChAtMNx0F3RcQYDKdvhBL4mBpiDkFA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 8 Nov 2022 10:08:36 +0100
Message-ID: <CAG_fn=VPvdHxQc3xm5xkqgFq3uo5oTU_w5vyMj-qQD7DvwQ4BA@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in pagecache_write
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> >
> > Anyway, this patch doesn't hurt, I suppose.  Can please you send it out as a
> > formal patch to linux-ext4?  It would be easy for people to miss this patch
> > buried in this thread.  Also, can you please send a patch to linux-f2fs-devel
> > for the same code in fs/f2fs/verity.c?
>
> Will do!

Shall I also initialize fsdata here:

$ git grep 'void \*fsdata;'
fs/affs/file.c:         void *fsdata;
fs/ext4/verity.c:               void *fsdata;
fs/f2fs/verity.c:               void *fsdata;
fs/hfs/extent.c:                void *fsdata;
fs/hfsplus/extents.c:           void *fsdata;
fs/ocfs2/mmap.c:        void *fsdata;

?
