Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9D13B0B8
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 18:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgANRTh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 12:19:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:44248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbgANRTh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Jan 2020 12:19:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E9989AD05;
        Tue, 14 Jan 2020 17:19:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DF62D1E0CB4; Tue, 14 Jan 2020 18:19:34 +0100 (CET)
Date:   Tue, 14 Jan 2020 18:19:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, jack@suse.cz
Subject: Re: [RFC 1/2] iomap: direct-io: Move inode_dio_begin before
 filemap_write_and_wait_range
Message-ID: <20200114171934.GB22081@quack2.suse.cz>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
 <20200114163702.GA7127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114163702.GA7127@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-01-20 08:37:02, Christoph Hellwig wrote:
> Using i_dio_count for any kind of detection is bogus.  If you want to
> pass flags to the writeback code please do so explicitly through
> struct writeback_control.

We want to detect in the writeback path whether there's direct IO (read)
currently running for the inode. Not for the writeback issued from
iomap_dio_rw() but for any arbitrary writeback that iomap_dio_rw() can be
racing with - so struct writeback_control won't help. Now if you want to
see the ugly details why this hack is needed, see my other email to Ritesh
in this thread with details of the race.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
