Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F23AA129
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhFPQZH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 12:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbhFPQYi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 12:24:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F231C061574;
        Wed, 16 Jun 2021 09:22:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h4so5256778lfu.8;
        Wed, 16 Jun 2021 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBQH65s6dXuvuY4ggi3ViJ5kPDHnKKmF/5YkqcMeyHA=;
        b=agK9vagT+8LIrZL92Cdy9ak31mdXjgDzQWfdH6nKNgeaecP9h2ba72ZSbqN0b0trRl
         BfXFR93UeiF1MaJ6RxADum8kmZKM+nfWi3RV4JpAUIL5MzzgTBlTB+BgxY1S427KJuhp
         eibyUfhLeeBRLvz30SWdh1vxihyvH7XKApa02zDeZlN0F+V8/QfjmA60umL0IPfunjzK
         iVKtl3EDf+hdgWS83CLBmqJ4Lb6Y1Ix39P2027CA3MVirxfnD1dvATA0ECCbv5Grg1pB
         VY6QroV6mglHPwaI6acRgU4jVhj2M03LPal1aztYif1swc1XKoDsRENUVYk5ZrYuPKJ7
         ZO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBQH65s6dXuvuY4ggi3ViJ5kPDHnKKmF/5YkqcMeyHA=;
        b=kbJcBWfEiiNUpcTxjhOpzJ6wlANguI88lruI7CEnLBzR2tbI6FdE1kkGIvgqMxBGxu
         BREezfLTtRFWhmIJaxbqbixU3Qq/jk985xeYfIVbkxdI3M7aSLvFqWwaVcePMv1ihyvr
         K4SjlVlCjft08O0peB0+aD4q4OY+ubv3pA4E2KVpFydHZdrpuS+Q+OTQqXqSSYc4GyKn
         Y+pBRs/Oy/RN1KbWdozkjAPVfY+DJPkFLEq5qt4mC0KYnVVNAdRaJid3nkxTbZo4ItAr
         HpeXeFa7EB/ZKOtA/JlnBINmyJJu7mUSHXqZgJWNlr7kKPRmSAcCeruJ6aGes99L60Oo
         n/xQ==
X-Gm-Message-State: AOAM530eFtI77VzfSbrApK8b12c2HTOHNWKf5wA+PL2FBEbsI2JM5Cf2
        6W/8qMW4yt+54NBdKC0tgV8=
X-Google-Smtp-Source: ABdhPJzZa5VoN+rWMnY/cl8INjSUP8iA/+pzdISzgajrwHeqHIHWjGqL/CC9jzQPPyRP6/Sq+9kwIA==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr341091lfc.201.1623860536422;
        Wed, 16 Jun 2021 09:22:16 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.24])
        by smtp.gmail.com with ESMTPSA id v18sm333032ljg.114.2021.06.16.09.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:22:16 -0700 (PDT)
Date:   Wed, 16 Jun 2021 19:22:13 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] INFO: task hung in ext4_fill_super
Message-ID: <20210616192213.1d75d8e2@gmail.com>
In-Reply-To: <0000000000004c80e405c4df1a2d@google.com>
References: <0000000000004c80e405c4df1a2d@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 16 Jun 2021 02:56:21 -0700
syzbot <syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f21b807c Merge tag 'drm-fixes-2021-06-11' of
> git://anongit.. git tree:       upstream
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=165fca57d00000 kernel
> config:  https://syzkaller.appspot.com/x/.config?x=30f476588412c065
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=c9ff4822a62eee994ea3 syz
> repro:
> https://syzkaller.appspot.com/x/repro.syz?x=17d19ce0300000 C
> reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108d7988300000
> 
> Bisection is inconclusive: the issue happens on the oldest tested
> release.
> 
> bisection log:
> https://syzkaller.appspot.com/x/bisect.txt?x=1646b8d0300000 final
> oops:     https://syzkaller.appspot.com/x/report.txt?x=1546b8d0300000
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=1146b8d0300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit: Reported-by:
> syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com
> 

Just want to try this ;)

#syz test https://linux.googlesource.com/linux/kernel/git/torvalds/linux refs/changes/76/10176/6


With regards,
Pavel Skripkin
