Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E998F66BC0C
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Jan 2023 11:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjAPKn7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Jan 2023 05:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjAPKne (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Jan 2023 05:43:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB319686
        for <linux-ext4@vger.kernel.org>; Mon, 16 Jan 2023 02:42:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E924676B5;
        Mon, 16 Jan 2023 10:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673865775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaK4gTEc3xivbVgXcrCo77AgfxH9KY+//Ri4fwvWfH0=;
        b=mMwM11zl4eBlHy+Ri65hhs2BgDS8SpGO1DAIXuqDGYHqcBm1glGj3jsNB/xQVC9GAC6bw3
        rErv3Cnb5AiQhVjlbdA8SJOdOqSM1ZzdPlW/J14ikvRXReCWjO+YPtbCLF/6W3HPP8UAcN
        Rws5E7W2upuzx8Zolf2Z9bx86t4BTNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673865775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaK4gTEc3xivbVgXcrCo77AgfxH9KY+//Ri4fwvWfH0=;
        b=e+Timl99VYEa7kr+TfZNDnrYiY41yKeyDNva1RS+5A16CplMOV18xyw6DZXmQToIcmfgRM
        mHrKWeyYSr6+CRCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72331138FE;
        Mon, 16 Jan 2023 10:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SYjhGy8qxWOPWQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 16 Jan 2023 10:42:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D463DA0746; Mon, 16 Jan 2023 11:42:54 +0100 (CET)
Date:   Mon, 16 Jan 2023 11:42:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Patrik Schindler <poc@pocnet.net>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Subject: Re: ext4: Remove deprecated noacl/nouser_xattr options
Message-ID: <20230116104254.xpphncpzu3zf53va@quack3>
References: <A5F622F8-99CF-4C7D-8811-7D82DB1C8846@pocnet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A5F622F8-99CF-4C7D-8811-7D82DB1C8846@pocnet.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On Sun 15-01-23 23:56:21, Patrik Schindler wrote:
> sorry for contacting you directly, but I struggle to find relevant
> information on this topic.

This is best discussed on ext4 development mailing list (added to CC).
 
> In this web page is documented that "noacl" for ext4 is deprecated.
> 
> https://patchwork.ozlabs.org/project/linux-ext4/patch/1658977369-2478-1-git-send-email-xuyang2018.jy@fujitsu.com/
> 
> Do you have some background information at hand why noacl is deprecated,
> and how to get the functionality of noacl after this change?

Yes, these options were deprecated for a long time (10 years) and now they are
removed since nobody complained. The reasoning is in commit f70486055ee
("ext4: try to deprecate noacl and noxattr_user mount options"):

No other file system allows ACL's and extended attributes to be
enabled or disabled via a mount option.  So let's try to deprecate
these options from ext4.

-

And it makes sense to me. It looks a bit strange and dangerous to disable
(part of) permission checks for the files. What usecase did you have for
it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
