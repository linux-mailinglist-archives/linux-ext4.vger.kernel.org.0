Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CDA66DB6C
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jan 2023 11:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbjAQKp3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Jan 2023 05:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbjAQKp2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Jan 2023 05:45:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE59026
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 02:45:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88135684EB;
        Tue, 17 Jan 2023 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673952325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJZmIS6caOhdRcX+Pqry5Uad9aBKXjnqii4Xj+dHO10=;
        b=B/2bqN4W14+N+r8EZXTRDmKk34DUbDqNoC9WXzRaXLELyDXcA85HiuP4RwI5lnV7a0pweb
        gLv4eHgM8+6G4+YgsbsnoHOHI3R5Ke7V0+92j9MnxLbYBzbQ3rj0xmICdqIXVfjLgFgUMg
        8t9U71DKyQSBoC/HgDY0v/uwwrhEaKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673952325;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJZmIS6caOhdRcX+Pqry5Uad9aBKXjnqii4Xj+dHO10=;
        b=JQobv2+J+74oiPgT2JL43JwgrjaAbm/1dHqbu4CyQBkqdlyb44KHDA00F7Guv10H53Eq/A
        tKtau9XVSXxF8lBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BD451390C;
        Tue, 17 Jan 2023 10:45:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xjQ0HkV8xmOFJQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 17 Jan 2023 10:45:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0E601A06B2; Tue, 17 Jan 2023 11:45:25 +0100 (CET)
Date:   Tue, 17 Jan 2023 11:45:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Patrik Schindler <poc@pocnet.net>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>
Subject: Re: ext4: Remove deprecated noacl/nouser_xattr options
Message-ID: <20230117104525.kmbypv4vca6lbd5a@quack3>
References: <A5F622F8-99CF-4C7D-8811-7D82DB1C8846@pocnet.net>
 <20230116104254.xpphncpzu3zf53va@quack3>
 <3C7004E8-E732-40C1-B0DD-2A2290E43AC5@pocnet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7004E8-E732-40C1-B0DD-2A2290E43AC5@pocnet.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Patrik!

On Mon 16-01-23 13:25:07, Patrik Schindler wrote:
> Am 16.01.2023 um 11:42 schrieb Jan Kara <jack@suse.cz>:
> 
> > On Sun 15-01-23 23:56:21, Patrik Schindler wrote:
> >> sorry for contacting you directly, but I struggle to find relevant
> >> information on this topic.
> > 
> > This is best discussed on ext4 development mailing list (added to CC).
> 
> Am I required to join that list?

No, the list is open so anyone can post to it.

> >> In this web page is documented that "noacl" for ext4 is deprecated.
> >> 
> >> https://patchwork.ozlabs.org/project/linux-ext4/patch/1658977369-2478-1-git-send-email-xuyang2018.jy@fujitsu.com/
> >> 
> >> Do you have some background information at hand why noacl is deprecated,
> >> and how to get the functionality of noacl after this change?
> > 
> > Yes, these options were deprecated for a long time (10 years) and now they are removed since nobody complained. The reasoning is in commit f70486055ee ("ext4: try to deprecate noacl and noxattr_user mount options"):
> > 
> > No other file system allows ACL's and extended attributes to be enabled
> > or disabled via a mount option.  So let's try to deprecate these
> > options from ext4.
> 
> Understood.
> 
> > And it makes sense to me. It looks a bit strange and dangerous to
> > disable (part of) permission checks for the files. What usecase did you
> > have for it?
> 
> I'm using Debian Linux 11.
> 
> When copy Files from my Mac via Samba to ext4 volumes, ACLs get added.
> (Much) earlier, this wasn't the case, and just UNIX permissions were in
> effect. For me, UNIX permissions are totally sufficient, and I can easily
> see what's going on with ls -l. For ACLs, I need to individually fiddle
> with get/setfacl.
> 
> This feels cumbersome to me and gives me a sense not having immediate
> control over access rights. Thus I'd like to find a way to get the
> previous behavior back. Ideally without recompiling samba to remove ACL
> support, as outlined here:
> https://serverfault.com/questions/828977/how-can-i-stop-samba-from-writing-extended-acls
> 
> For a very long time I had noacl in my fstab but with the update to
> Debian 11, I saw the message about the deprecation. Not sure when I
> observed ACLs being actually written by Samba, though.
> 
> In addition, even newer Google hits almost entirely state "noacl in fstab
> to suppress ACLs for ext4", so I'm probably not the only one trying to
> disable them and people largely failed to understand that noacl has no
> effect anymore.

I understand the wish for more overview over file permissions but this
seems like a bit awkward way to reach it? It rather seems like a lack of
control in the smbget(1) tool (or whatever you are using for the copying)?
Adding an option there to not copy permissions from the server would look
like a very logical thing to do (similarly as cp(1) has these options)...
Would that work?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
