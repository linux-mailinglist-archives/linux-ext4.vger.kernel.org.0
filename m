Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D39B75776E
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jul 2023 11:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGRJKl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Jul 2023 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGRJKk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Jul 2023 05:10:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7669AE4C;
        Tue, 18 Jul 2023 02:10:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D5872195F;
        Tue, 18 Jul 2023 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689671434;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjTjy8bD3w9DvRPImUgRpOPNPTrxRdwaCRNZC4ChKoU=;
        b=MBiFUahqa/MCGv/mqC8Ps52wf8DzczakgtxZMqZSuHa+5iNwPFoADR6fcr4EG1yKUWPXKP
        dKbUqMsQdrn6kpPmRpNonkieRdJw6CCcVbohvpQ8icnfTjl1CLsuxj78Fc/46+01ThCOVx
        1iOGHQAlOVdJLIjOdYdNIiKRM/H6aPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689671434;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjTjy8bD3w9DvRPImUgRpOPNPTrxRdwaCRNZC4ChKoU=;
        b=x8C9NF5/Qyg+tX17//LLcfNgr5MhVohJLIfu9eo4JqX0SUVHTURTy403q3dyWagM9jOx+j
        AS4rr9UdHBVxP7Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8486613494;
        Tue, 18 Jul 2023 09:10:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 97IkHglXtmSGWgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 18 Jul 2023 09:10:33 +0000
Date:   Tue, 18 Jul 2023 11:10:31 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [LTP] next: kernel BUG at fs/ext4/mballoc.c:4369!
Message-ID: <20230718091031.GB1140910@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230717213424.GB3842864@mit.edu>
 <87h6q2nfr7.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6q2nfr7.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> "Theodore Ts'o" <tytso@mit.edu> writes:

> > On Mon, Jul 17, 2023 at 08:04:54PM +0530, Ritesh Harjani wrote:

> >> These can basically trigger in extremely low memory space and only when
> >> such ranges exist in the PA rbtree. Hence, I guess it is a little hard
> >> to tigger race.

> > Ritesh, thanks for looking into this!

> > Naresh, how easy is it for you to trigger the BUG when using LTP?  I
> > did two xfstests runs using "gce-xfstests -c ext2/default -g auto",
> > one on the ext4 dev branch, and one on linux-next 20230717, and I
> > wasn't able to trigger the BUG.

> > If you can trivially trigger it using LTP (perhaps with a low memory
> > configuration in your test setup?), that would be useful to know.

> Hi Ted,

Hi Ted, Ritesh, all,

> Sorry for wrong choice of words. By low memory space I meant low disk
> space i.e. ENOSPC test (fs_fill). I reproduced it like this - 

> root@ubuntu:/opt/ltp# while [ 1 ]; do ./runltp -s fs_fill; sleep 1; done

Late, but better than never: LTP C tests can be run without any wrapper.
e.g. to reproduce the bug triggered by fs_fill, you can just:

git clone https://github.com/linux-test-project/ltp.git && cd ltp
./ci/your-distro.sh # optionally install the dependencies
make autotools
./configure
cd testcases/kernel/fs/fs_fill/
make -j`nproc`
while true; do ./fs_fill; sleep 1; done

NOTE: runltp is
1) deprecated, replaced by runltp-ng [1]
2) again, there is no need to use this shell wrapper to run a single C binary

Kind regards,
Petr

[1] https://github.com/linux-test-project/runltp-ng

> For me it took around ~1-2 hours for it to reproduce when I tried again.
> I am hoping if we run generic/269 (fsstress ENOSPC) in a while loop like
> this maybe it can hit this bug. But I didn't give it a shot.

> -ritesh
