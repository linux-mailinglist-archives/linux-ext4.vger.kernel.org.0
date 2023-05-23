Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6F70DB49
	for <lists+linux-ext4@lfdr.de>; Tue, 23 May 2023 13:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjEWLOK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 May 2023 07:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEWLOJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 May 2023 07:14:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA9DC4;
        Tue, 23 May 2023 04:14:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 629022189E;
        Tue, 23 May 2023 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684840447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aY4cNcj2buXA+98cdjoFDFDl/OCoE3o4iIFcicP0g64=;
        b=TQmkosjcuOUYgoKQws17rh7W3oXsCkxxXBnr+m57gLBw5bZwc29zThN5ROEIVx4WkM9b7b
        AF1HPj1ZbpVHu+j5Uvrk7zLWE48xeuA9v/s40Ku8qUWYN3vuibWwh2e8kKnAROly6MwdW0
        QgRE67JkR3LG4d4tlFjsLT1JKWJPFAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684840447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aY4cNcj2buXA+98cdjoFDFDl/OCoE3o4iIFcicP0g64=;
        b=UC7EAxKtgjTXtFULg/jASLhyIZCBIObuakZPQk26tXQp3M4IDK5p8Pl7Kjt/lsvM1ioObb
        rCBhbOEEPRdAwsAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A213D13A10;
        Tue, 23 May 2023 11:14:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pb2AJ/2fbGRvBwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 May 2023 11:14:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2E3E9A075D; Tue, 23 May 2023 12:46:44 +0200 (CEST)
Date:   Tue, 23 May 2023 12:46:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix possible corruption when moving a directory
Message-ID: <20230523104644.dgvmjq4xzhemlpbm@quack3>
References: <20230126112221.11866-1-jack@suse.cz>
 <20230517045836.GA11594@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517045836.GA11594@frogsfrogsfrogs>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 16-05-23 21:58:36, Darrick J. Wong wrote:
> On Thu, Jan 26, 2023 at 12:22:21PM +0100, Jan Kara wrote:
> > When we are renaming a directory to a different directory, we need to
> > update '..' entry in the moved directory. However nothing prevents moved
> > directory from being modified and even converted from the inline format
> > to the normal format. When such race happens the rename code gets
> > confused and we crash. Fix the problem by locking the moved directory.
> 
> Four months later, I have a question --
> 
> Is it necessary for ext4_cross_rename to inode_lock_nested on both
> old.inode and new.inode?  We're resetting the dotdot entries on both
> children in that case, which means that we also need to lock out inline
> data conversions, right?

Ouch, you're right. In that path we need to lock both source & target
directories since lock_two_nondirectories() call in vfs_rename() will not
lock them... I'll send a patch. Thanks for spotting this!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
