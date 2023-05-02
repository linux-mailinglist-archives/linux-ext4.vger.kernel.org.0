Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02BB6F406B
	for <lists+linux-ext4@lfdr.de>; Tue,  2 May 2023 11:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjEBJvn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 May 2023 05:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjEBJv3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 May 2023 05:51:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EF95254
        for <linux-ext4@vger.kernel.org>; Tue,  2 May 2023 02:51:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C556421B75;
        Tue,  2 May 2023 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683021084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ZoIt/z6j3Q+wBI0TkFA8ifBld+pE1kZesndHav6sDI=;
        b=gWqAjFW3fN0cXMwEZ/rpuTVYcVOr5ObjCFGF+bffXSWO8LHq2Ie3uqe6XhvrEuYEtntA+P
        AuJW0/7oeX998XCdiKmPs1vbR73uL+WqJ02VrVZum7oeisyFpiHX9DHu1gLta30eeFVYlH
        jmu9510Zt2ZbiDhgr/RKUOY5ijLhpTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683021084;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ZoIt/z6j3Q+wBI0TkFA8ifBld+pE1kZesndHav6sDI=;
        b=1oc6NpX7Zw7ERXk2MH3IwXUdXaR40qv/5sA0lLMsPtpgbecdjm3P40LWIBnRxKAKO2XBXi
        0YQDb29lLj+1dxAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9A9E139C3;
        Tue,  2 May 2023 09:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iiNJLRzdUGRRYgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 02 May 2023 09:51:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 40866A0735; Tue,  2 May 2023 11:51:24 +0200 (CEST)
Date:   Tue, 2 May 2023 11:51:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        syzbot+aacb82fca60873422114@syzkaller.appspotmail.com,
        syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Fix lockdep warning when enabling MMP
Message-ID: <20230502095124.gzjjnmfquciimucf@quack3>
References: <20230411121019.21940-1-jack@suse.cz>
 <ZE6YeCaQa01nAWYT@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZE6YeCaQa01nAWYT@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 30-04-23 12:34:00, Theodore Ts'o wrote:
> On Tue, Apr 11, 2023 at 02:10:19PM +0200, Jan Kara wrote:
> > When we enable MMP in ext4_multi_mount_protect() during mount or
> > remount, we end up calling sb_start_write() from write_mmp_block(). This
> > triggers lockdep warning because freeze protection ranks above s_umount
> > semaphore we are holding during mount / remount. The problem is harmless
> > because we are guaranteed the filesystem is not frozen during mount /
> > remount but still let's fix the warning by not grabbing freeze
> > protection from ext4_multi_mount_protect().
> > 
> > Reported-by: syzbot+aacb82fca60873422114@syzkaller.appspotmail.com
> 
> I believe this is the wrong Reported-by.  The correct one looks like
> it should be:
> 
> Reported-by: syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=ab7e5b6f400b7778d46f01841422e5718fb81843

Well, one of the reports of this problem has also the ID I have referenced
(https://syzkaller.appspot.com/bug?extid=6b7df7d5506b32467149).  There are
apparently multiple ones...

> It's also helpful to add a Link line to the Syzkaller dashboard to
> make it easier to find the relevant Syzbot report.

Right, I'll do that next time. Thanks for the idea.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
