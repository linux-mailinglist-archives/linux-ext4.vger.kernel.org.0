Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B035826CD40
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 22:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgIPU5B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 16:57:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgIPQwi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Sep 2020 12:52:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EB0CABD1;
        Wed, 16 Sep 2020 16:52:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C2A631E12E1; Wed, 16 Sep 2020 18:52:36 +0200 (CEST)
Date:   Wed, 16 Sep 2020 18:52:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>
Subject: Re: [RFC PATCH v3 2/3] jbd2, ext4, ocfs2: introduce/use journal
 callbacks j_submit|finish_inode_data_buffers()
Message-ID: <20200916165236.GN3607@quack2.suse.cz>
References: <20200910193127.276214-1-mfo@canonical.com>
 <20200910193127.276214-3-mfo@canonical.com>
 <20200916162240.GM3607@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916162240.GM3607@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 16-09-20 18:22:40, Jan Kara wrote:
> On Thu 10-09-20 16:31:26, Mauricio Faria de Oliveira wrote:
> > @@ -1111,6 +1113,27 @@ struct journal_s
> >  	void			(*j_commit_callback)(journal_t *,
> >  						     transaction_t *);
> >  
> > +	/**
> > +	 * @j_submit_inode_data_buffers:
> > +	 *
> > +	 * This function is called for all inodes associated with the
> > +	 * committing transaction marked with JI_WRITE_DATA flag
> > +	 * before we start to write out the transaction to the journal.
> > +	 */
> > +	int			(*j_submit_inode_data_buffers)
> > +					(struct jbd2_inode *);
> > +
> > +	/**
> > +	 * @j_finish_inode_data_buffers:
> > +	 *
> > +	 * This function is called for all inodes associated with the
> > +	 * committing transaction marked with JI_WAIT_DATA flag
> > +	 * after we have written the transaction to the journal
> > +	 * but before we write out the commit block.
> > +	 */
> > +	int			(*j_finish_inode_data_buffers)
> > +					(struct jbd2_inode *);
> > +
> 
> Having the callbacks in the journal_s will not work if we have inodes with
> data journalling on a filesystem mounted in data=ordered mode. The
> callbacks really need to be a per-inode thing so I'd add them to struct
> jbd2_inode.

Oh, now I see that you properly handle this in the callbacks. So I retract
this objection. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

after removing those pointless wrappers.

								Hoonza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
