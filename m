Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC0560C6FF
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Oct 2022 10:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiJYI4G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Oct 2022 04:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJYI4F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Oct 2022 04:56:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C491153E22
        for <linux-ext4@vger.kernel.org>; Tue, 25 Oct 2022 01:56:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 25A3B220B5;
        Tue, 25 Oct 2022 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666688162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PnP93ZsW3QY9+WM94FhgAgSIsKs88K2mdQVVyO6Nn08=;
        b=S+oDBjyVzQF4oD9tFWAJx8nXnf4aBiNvoqq3OJ6AafupLYxPdHF7TDhE5Mm2s9/yvAsvBD
        9yy8GMbL1y+64jyevgJgkl6ENQipJRB7Z4tNfMC/Fomvi6KyPmZMqTyryidUgXgbtqwW5w
        RZjxNljtnjdMBqaO2xnoxS7Eol0j1a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666688162;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PnP93ZsW3QY9+WM94FhgAgSIsKs88K2mdQVVyO6Nn08=;
        b=GIPDrMxs/4KpF/AvBJXJht1jVw6Iu/eeszwa29HLLHnwDZ8y1Oas/oOf4R8IUDz1E9PdlA
        uxs9o+y0R1Pdb6Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 170E713A98;
        Tue, 25 Oct 2022 08:56:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wl8UBaKkV2PiLgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 25 Oct 2022 08:56:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9470CA06F5; Tue, 25 Oct 2022 10:56:01 +0200 (CEST)
Date:   Tue, 25 Oct 2022 10:56:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix wrong return err in
 ext4_load_and_init_journal()
Message-ID: <20221025085601.gpxh5stotqx7to54@quack3>
References: <20221022130739.2515834-1-yanaijie@huawei.com>
 <20221024152946.gafegxwrv5i5djvn@quack3>
 <8b2e325c-057b-3287-c38e-0ca5b936d4db@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2e325c-057b-3287-c38e-0ca5b936d4db@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 25-10-22 11:27:01, Jason Yan wrote:
> 
> On 2022/10/24 23:29, Jan Kara wrote:
> > On Sat 22-10-22 21:07:39, Jason Yan wrote:
> > > The return value is wrong in ext4_load_and_init_journal(). The local
> > > variable 'err' need to be initialized before goto out. The original code
> > > in __ext4_fill_super() is fine because it has two return values 'ret'
> > > and 'err' and 'ret' is initialized as -EINVAL. After we factor out
> > > ext4_load_and_init_journal(), this code is broken. So fix it by directly
> > > returning -EINVAL in the error handler path.
> > > 
> > > Fixes: 9c1dd22d7422 (ext4: factor out ext4_load_and_init_journal())
> > 
> > We format the tag usually as:
> > 
> > Fixes: 9c1dd22d7422 ("ext4: factor out ext4_load_and_init_journal()")
> > 
> 
> Oh, sorry I didn't notice it. Thank you so much.
> 
> I generate this tag by the following script:
> 
> #cat .gitconfig
>  [alias]
>          fixes = log --abbrev=12 -1 --format='Fixes: %h ("%s")'
> 
> 
> #git fixes 9c1dd22d742249cfae7bbf3680a7c188d194d3ce
> Fixes: 9c1dd22d7422 (ext4: factor out ext4_load_and_init_journal())
> 
> This works fine before but it fails recently. I don't know what makes the
> behavior changed.

I guess something does one more round of expansion on the string. I guess
you could trace it with strace and see where the quotes get lost...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
