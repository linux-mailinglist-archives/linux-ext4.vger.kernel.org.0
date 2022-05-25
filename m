Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3345340D8
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 17:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiEYP5v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 11:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245218AbiEYP5t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 11:57:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D564BDD;
        Wed, 25 May 2022 08:57:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F2374219F5;
        Wed, 25 May 2022 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653494266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M2rR0Mt9aNzbADhl4nuio4a0c9AH3DiINVqGdx50lWk=;
        b=qy/BfGSwupZVQJgnZi4bTX+kIWc3p4f8hlVX9gW2w6zYBbhmKWS/MxcBrpcA0TY+uDxQ7z
        5pFAzMWK2jqH2tqNZdXoJRwQfBTaKsyJlfUCiNiQ12JK5ov22e1Y81L9p+sSvEtLhHW0Td
        YukST6h9DdaKGLmlvMXyhxeCvBxxAis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653494266;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M2rR0Mt9aNzbADhl4nuio4a0c9AH3DiINVqGdx50lWk=;
        b=FE3miYJiqnMi5CaTZwTot5BCSM2V85L9RHDM+2vsB9YaPMKlG9E64G1CzVTVMw97UgjDt3
        nuWKmso6QpJQhoAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8C5DE2C141;
        Wed, 25 May 2022 15:57:45 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9E70AA0632; Wed, 25 May 2022 17:57:42 +0200 (CEST)
Date:   Wed, 25 May 2022 17:57:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext4: fix super block checksum incorrect after
 mount
Message-ID: <20220525155742.gcqoeidcyii7mzx6@quack3.lan>
References: <20220525012904.1604737-1-yebin10@huawei.com>
 <20220525075123.rx5v7fe6ocn354wn@riteshh-domain>
 <20220525115400.kr3urpp3cf3hybvi@quack3.lan>
 <20220525151612.an7xysp242urynbp@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525151612.an7xysp242urynbp@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 25-05-22 20:46:12, Ritesh Harjani wrote:
> On 22/05/25 01:54PM, Jan Kara wrote:
> > On Wed 25-05-22 13:21:23, Ritesh Harjani wrote:
> > > On 22/05/25 09:29AM, Ye Bin wrote:
> > > > We got issue as follows:
> > > > [home]# mount  /dev/sda  test
> > > > EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
> > > > [home]# dmesg
> > > > EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
> > > > EXT4-fs (sda): Errors on filesystem, clearing orphan list.
> > > > EXT4-fs (sda): recovery complete
> > > > EXT4-fs (sda): mounted filesystem with ordered data mode. Quota mode: none.
> > > > [home]# debugfs /dev/sda
> > > > debugfs 1.46.5 (30-Dec-2021)
> > > > Checksum errors in superblock!  Retrying...
> > > >
> > > > Reason is ext4_orphan_cleanup will reset ‘s_last_orphan’ but not update
> > > > super block checksum.
> > > > To solve above issue, defer update super block checksum after ext4_orphan_cleanup.
> > >
> > > I agree with the analysis. However after [1], I think all updates to superblock
> > > (including checksum computation) should be done within buffer lock.
> > > (lock_buffer(), unlock_buffer()).
> > >
> > > [1]: https://lore.kernel.org/all/20201216101844.22917-4-jack@suse.cz/
> >
> > So technically you're right that we should hold buffer lock all the time
> > from before we modify superblock buffer until we recompute the checksum (so
> > that we avoid writing superblock with mismatched checksum). To do this we'd
> > have to put checksum recomputations and superblock buffer locking into
> > ext4_orphan_cleanup() around setting of es->s_last_orphan (in three places
> > there AFAICS). A bit tedious but it would actually also fix a (theoretical)
> > race that someone decides to write out superblock after we set
> > s_last_orphan but before we set the checksum.
> 
> Ok. Although (I think) it can still be done at just one place before returning
> from ext4_orphan_cleanup().
> But I agree it is mostly a theoretical race (in fact since this is happening
> during mount, I am not sure if it is even possible?) and there might not
> be any value addition in doing so by complicating it too much.

Well, what could presumably happen is that if someone dirtied superblock
(say while processing orphan list), then flush worker could come just after
we set s_last_orphan and before we update the checksum. Now I don't think
we currently dirty superblock during orphan cleanup but it is certainly
slightly fragile to rely on this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
