Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3A3722A7B
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 17:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjFEPJN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjFEPJA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 11:09:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BCAEA;
        Mon,  5 Jun 2023 08:08:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F4F821B77;
        Mon,  5 Jun 2023 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685977736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6Fpv18tPkZl3njhXBvdawu8JHw6otAv8L2MKSyYslo=;
        b=zirSbKRWhfhtvxOs7QBUaHa9zQLlEc1gyBvl4SlcmMPoIXaYRFedTk2Ld7zq6EJHO6r+FZ
        AfvxJUGs4+GeP2Fs9rAAUFEbv8t2GOJmYexdw/dDiVpioOMdLGySXojNygfq/xIGslEgqK
        ju6S2u/3/ypu9NbMgGld5W6GBeKV+4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685977736;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6Fpv18tPkZl3njhXBvdawu8JHw6otAv8L2MKSyYslo=;
        b=zhdG6TkIMVNl1iVrLLr0DVEvvNEQdqEzR7hOX5p1HLtF2gXg4ukoU5VZh7D/RS8jG0gPgm
        BL3LSYipgRoJ4dAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B0ED139C8;
        Mon,  5 Jun 2023 15:08:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6dBCEoj6fWTvagAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 05 Jun 2023 15:08:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C14D1A0754; Mon,  5 Jun 2023 17:08:55 +0200 (CEST)
Date:   Mon, 5 Jun 2023 17:08:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, jun.nie@linaro.org,
        ebiggers@kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
        yukuai3@huawei.com,
        syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix race condition between buffer write and
 page_mkwrite
Message-ID: <20230605150855.7oaiplp7r57dcww3@quack3>
References: <20230530134405.322194-1-libaokun1@huawei.com>
 <20230604030445.GF1128744@mit.edu>
 <20230604210821.GA1257572@mit.edu>
 <ZH1BN+H1/Sa4eLQ4@casper.infradead.org>
 <20230605091655.24vl5fjesfskt3o5@quack3>
 <20230605122141.4njwwx3mrapqhvt4@quack3>
 <ZH33ZzwyLFY48tfA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH33ZzwyLFY48tfA@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 05-06-23 15:55:35, Matthew Wilcox wrote:
> On Mon, Jun 05, 2023 at 02:21:41PM +0200, Jan Kara wrote:
> > On Mon 05-06-23 11:16:55, Jan Kara wrote:
> > > Yeah, I agree, that is also the conclusion I have arrived at when thinking
> > > about this problem now. We should be able to just remove the conversion
> > > from ext4_page_mkwrite() and rely on write(2) or truncate(2) doing it when
> > > growing i_size.
> > 
> > OK, thinking more about this and searching through the history, I've
> > realized why the conversion is originally in ext4_page_mkwrite(). The
> > problem is described in commit 7b4cc9787fe35b ("ext4: evict inline data
> > when writing to memory map") but essentially it boils down to the fact that
> > ext4 writeback code does not expect dirty page for a file with inline data
> > because ext4_write_inline_data_end() should have copied the data into the
> > inode and cleared the folio's dirty flag.
> > 
> > Indeed messing with xattrs from the writeback path to copy page contents
> > into inline data xattr would be ... interesting. Hum, out of good ideas for
> > now :-|.
> 
> Is it so bad?  Now that we don't have writepage in ext4, only
> writepages, it seems like we have a considerably more benign locking
> environment to work in.

Well, yes, without ->writepage() it might be *possible*. But still rather
ugly. The problem is that in ->writepages() i_size is not stable. Thus also
whether the inode data is inline or not is not stable. We'd need inode_lock
for that but that is not easily doable in the writeback path - inode lock
would then become fs_reclaim unsafe...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
