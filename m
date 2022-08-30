Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D35A5D3E
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Aug 2022 09:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiH3HqU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Aug 2022 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiH3HqS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Aug 2022 03:46:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ED2BF4
        for <linux-ext4@vger.kernel.org>; Tue, 30 Aug 2022 00:46:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v26so4133488lfd.10
        for <linux-ext4@vger.kernel.org>; Tue, 30 Aug 2022 00:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uFj3dWyaNltOtTP1hSbuJPM+mKs6xZPTqlIbqwCP0iE=;
        b=oWsblSWh51Ii4rve4U8d7579vL7agXtF635XvxUZr+mCJ2CfjWHqtUdF+CCOKAlXJD
         XcmXBuv2YBRN6V5IkBTRVMFhuryRNc/LczdCn8D2MEi51TTViv09oH+w8DhD1lyYAbKh
         V0o7oaiuszZG21ldZGXnAXUv2zUlZIl4+w1x0pomLw89pW9aAmbNvsDuuKcBb9RrwMbY
         kEEmqtHm1zGmfpVTZHAaR57mBFKnvs73he5q9UMgtWRn1Z5sr+qAZRoUYbv3mVh+60TV
         sBU6WGeRygB/2mZNwXj2ziKczp94Lm6mmCp07UlN/vzCm5O2jbiGGP/hlpJnRbGq2z7f
         //SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uFj3dWyaNltOtTP1hSbuJPM+mKs6xZPTqlIbqwCP0iE=;
        b=g1hFvKZMai0CtovSQMexWoCuOzPJvzAQQQ5ChM+KvU/FIgz51Uj0TaJo/0CWBBypXS
         0ysvuxyXMCqNncAbZX/0Ou71LsRnrh9M/w8tMnciMOletjO2Ylj3lFqbMHRShsK/tbDD
         ASrRJHHp8dQiWWbp8Ltew0RIcOLQdFoHVaP7gaD8xnNuPF+nMyH7Tc9o5hzq3lDoIdax
         piN3X5vNlPdQHq7b/k3sHQ3RK3KgFOZ7QjvS/Pnto1S2PP4e11HjUBzkwwETDmmXgC0Y
         AgUx8FQ5Fugfh61o4pvoYCOMV5JhELphl58GaAqBYaoBulMXBL3a9YXjU3hFFP/n7J1A
         KefA==
X-Gm-Message-State: ACgBeo0noGTvZLMYo2W3CZ+38Dete1mnlTHMhg00wsOLnX2Crz26hKFQ
        stHj8iP0zX1LK957CbyogojAcMTW+XracwjUEdnbBw==
X-Google-Smtp-Source: AA6agR5n1XoJbtC+rrhTHExiksN06G4eFQG0O70O/W+KxUJ0fDYbQp7iGoXyyNbXK+8G4PvftUC5HJOARslXHThYr4s=
X-Received: by 2002:a05:6512:118b:b0:492:e3c4:a164 with SMTP id
 g11-20020a056512118b00b00492e3c4a164mr7990180lfr.598.1661845575525; Tue, 30
 Aug 2022 00:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004c915205b1a04ad9@google.com> <000000000000662b4a05e7603e42@google.com>
 <YwzLBls/xEMz4d+s@kroah.com>
In-Reply-To: <YwzLBls/xEMz4d+s@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 30 Aug 2022 09:46:03 +0200
Message-ID: <CACT4Y+aCFzhaTS-_D3qU_svaNbum2Rpc3k6Y9_UCb=vA8MOqiw@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG at fs/ext4/inline.c:LINE!
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, hch@lst.de, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        phil@philpotter.co.uk, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 29 Aug 2022 at 16:19, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 29, 2022 at 05:17:13AM -0700, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 1045a06724f322ed61f1ffb994427c7bdbe64647
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Wed Jun 29 15:01:02 2022 +0000
> >
> >     remove CONFIG_ANDROID
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16ab0893080000
> > start commit:   a8ad9a2434dc Merge tag 'efi-urgent-for-v5.16-2' of git://g..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2ebd4b29568807bc
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4faa160fa96bfba639f8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114ae045b00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1785e92bb00000
> >
> > If the result looks correct, please mark the issue as fixed by replying with:
> >
> > #syz fix: remove CONFIG_ANDROID
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> I really doubt that ext4 has anything to do with the removal of
> CONFIG_ANDROID

Agree.

Looking at:
$ git log --oneline fs/ext4/inline.c

The following recent commit fixes a very similar failure mode:

#syz fix: ext4: fix bug_on in ext4_writepages
