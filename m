Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5621C6F26A1
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Apr 2023 23:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjD2VsD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Apr 2023 17:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD2VsD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Apr 2023 17:48:03 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A56E10F3
        for <linux-ext4@vger.kernel.org>; Sat, 29 Apr 2023 14:47:59 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33TLlpKl007769
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Apr 2023 17:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682804874; bh=RZSICHIOVIFONjKPxLv76+f0uM89N9ti2s6UBs/bvm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=STtP53cLvJNh4ApeYEjd725vdiJ3VIX5DjlytFnATXjOaTLM9byLP2/RdAnSOwTvx
         7EmmHECJJ8HnxkoIWw0ACynatfXt8KBG8tTOhgfsuFIDhFPMiZMWNadeand8mK6DaN
         Qs1UnUJhIJPReK6yYdAXlR86dC9XUimrf907Z6OE//ssnAA6NJOeCBVHjfPvBD+dIo
         22jcYux9OXPyDRoNETcVmIIGXnTiVAZu4PJEZzQDbh/ANfyFgIuylEixPflbcOQRNU
         beWOd2X1THC2Z4iXFF8+UyjsvA3/ie4rbQaCeBu630h1KlToDtD6VrYRx8XckUIACU
         4LAqbGXz1RofQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 195E68C022E; Sat, 29 Apr 2023 17:47:51 -0400 (EDT)
Date:   Sat, 29 Apr 2023 17:47:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+ecab51a4a5b9f26eeaa1@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [syzbot] WARNING in ext4_dirty_folio
Message-ID: <ZE2QhyNzgMo8KFVS@mit.edu>
References: <0000000000003fb2e905db20ac96@google.com>
 <00000000000031695705e0ee1d58@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000031695705e0ee1d58@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz set subsystems: mm

On Wed, Jun 08, 2022 at 04:36:20AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    cf67838c4422 selftests net: fix bpf build error
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=123c2173f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fc5a30a131480a80
> dashboard link: https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1342d5abf00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ecafebf00000

The root cause of this failure is a fundamental bug / design flaw in
get_user_pages and related functions, which file system developers
have been complaining about for literally **years**.  See the recent
discussion at [1] and going back earlier to 2018[2][3] and 2019[4].

[1] https://lore.kernel.org/all/6b73e692c2929dc4613af711bdf92e2ec1956a66.1682638385.git.lstoakes@gmail.com/
[2] https://lwn.net/Articles/753027/
[3] https://lwn.net/Articles/774411/
[4] https://lwn.net/Articles/784574/

I'm going to reassign this to the mm subsystem, since there's not much
we can do on the file system end.  The WARNING is considered a good
thing because users can see silent data corruption/loss if they use
process_vm_writev() or RDMA to write to memory backed by a file.  And
while most users at large hyperscale scientific compute farms probably
won't be paying attention to the system logs, at least we've done
something to warn them.

Fortunately data corruption is rare (but when it happens it could
really screw with your results!), but if they are doing some large
scale simulation to evaluate the safety of nuclear weapons (for
example), it would be nice if they got at least some hint.

There is a potential solution discussed at [1], but there is push back
since it could break users by disallowing the thing that might cause
data corruption.  Why breaking user applications is bad, turning a
possible silent data corruption to a very visible, hard failure is
arguably a good thing....

						- Ted
