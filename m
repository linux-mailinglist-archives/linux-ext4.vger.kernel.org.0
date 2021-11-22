Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA070459665
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Nov 2021 22:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhKVVMW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Nov 2021 16:12:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49576 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhKVVMQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Nov 2021 16:12:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1455321891;
        Mon, 22 Nov 2021 21:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637615349;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7vSeuM+UkXq+4iVBqwr0QlYFSjV8HldzhJA1G3tz+oo=;
        b=bdNN9+3GO0t/ZJwNo/ntHweKuPFkX+p0ufufF7NwxPTePnEHyzxF4XEK4+insnKQKMwA3B
        mIjQPHJSF5zJolRdGKD6xNHBu2Y5IfcBvpxiGSqakUXxeMtjuLIBOCC12m6AyM8R9cjJxD
        vVqiNnH7KdCWsRkJpVEwgztNYyI0EQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637615349;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7vSeuM+UkXq+4iVBqwr0QlYFSjV8HldzhJA1G3tz+oo=;
        b=cJHjmUzwcOspkFtxUaSX1oepCoAfz3PwxihV5hwYkT8pZP2nbCcOQUD91SPVpHSOBQs9R9
        VX+H72qrkMlJ57AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AA3313B68;
        Mon, 22 Nov 2021 21:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3g8qBfQGnGG7HwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 22 Nov 2021 21:09:08 +0000
Date:   Mon, 22 Nov 2021 22:09:06 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.com>,
        Matthew Bobrowski <repnop@google.com>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
Message-ID: <YZwG8nfFmR+q915S@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
 <8735nsuepi.fsf@collabora.com>
 <YZtLDXW01Cz0BfPU@pevik>
 <87mtlwt7p6.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtlwt7p6.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,
> Petr Vorel <pvorel@suse.cz> writes:

> > Hi all,

> > <snip>
> >> Hi Amir,

> >> I have pushed v4 to :

> >> https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4

> > FYI I've rebased it on my fix 3b2ea2e00 ("configure.ac: Add struct
> > fanotify_event_info_pidfd check")

> > https://github.com/linux-test-project/ltp.git -b gertazi/fanotify21.v4.fixes

> > diff to krisman/fan-fs-error_v4:

> Petr,

> Should I send a v5 or is v4 getting picked up and merged with the fixup
> hunk?
No need to sent v4, I'll merge it from my branch. This is info for Amir, which
wanted to use your git tree to base his patchset on (if it wasn't relevant only
to patches for man-pages).

Kind regards,
Petr
