Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AA174AA33
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jul 2023 07:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjGGFK1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jul 2023 01:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjGGFK0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jul 2023 01:10:26 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D271BDB
        for <linux-ext4@vger.kernel.org>; Thu,  6 Jul 2023 22:10:22 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-265819aa743so1018969a91.1
        for <linux-ext4@vger.kernel.org>; Thu, 06 Jul 2023 22:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688706622; x=1691298622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3odBP2k8JVrJYy1wa0Wfn0VRWmDTDDoVrfM0d6n+ayY=;
        b=de22cnwJtxulQs479uGc6/SpQrXx9PLsRRUghHeD0/FFnFKS2H3lN7GwyHZO26EIO8
         trf191YUwwl9L9BbRBP5mU7swJIE+4PSXLPZnXHFa4VqiWW7PuLo4fTfYRAZWnn21XUt
         YF4fy1Rj1NqhmKZfvm5E3cCW1mj/KvxPqtXTRnE+4zITZH6fL4x9TQa+5O6f1tLl+RtG
         Ju21gZND2MHOVPiixjYXqtKXI4eXe6Kx1YQx+WbwP7h4zuxtO+23W6X0EQDidlGt9fqd
         swngrWTEy+EObqmDCa3McuW+UweCjb8CkxAH74gVQIpFSOiJFUz5zJC6XQTNxkkx+R1F
         iytw==
X-Gm-Message-State: ABy/qLauh/5/IzmC8/6587l1onGMTmDWOMIlpynaCEVjPm9pmykDC46Q
        KE5CdkCxVtgTpx3HWMDZBPYSuf8b8tPRJaQ0Af95ZVu36g7S
X-Google-Smtp-Source: APBJJlFPEIIvaQ5FzGgKwrTTH+IL4zi+h8xLaZxAtxA/83enB/W2VDTaFHWmkb5XXkGxd63ab2vboDyFilTDCFmVWY2UF8XrN5eI
MIME-Version: 1.0
X-Received: by 2002:a17:902:e549:b0:1b7:f5be:c934 with SMTP id
 n9-20020a170902e54900b001b7f5bec934mr4087715plf.9.1688706621980; Thu, 06 Jul
 2023 22:10:21 -0700 (PDT)
Date:   Thu, 06 Jul 2023 22:10:21 -0700
In-Reply-To: <000000000000a557cb05ff9ed03b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000554b8205ffdea64e@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in ext4_finish_bio
From:   syzbot <syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, boqun.feng@gmail.com,
        dhowells@redhat.com, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has bisected this issue to:

commit b6d972f6898308fbe7e693bf8d44ebfdb1cd2dc4
Author: David Howells <dhowells@redhat.com>
Date:   Fri Jun 16 11:10:32 2023 +0000

    crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e4fa88a80000
start commit:   ae230642190a Merge branch 'af_unix-followup-fixes-for-so_p..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1414fa88a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1014fa88a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=689ec3afb1ef07b766b2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136b9d48a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10223cb8a80000

Reported-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com
Fixes: b6d972f68983 ("crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
