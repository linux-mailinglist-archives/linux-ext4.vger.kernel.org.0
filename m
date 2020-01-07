Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C48132CE2
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 18:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgAGRWj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 12:22:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:54184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbgAGRWj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 7 Jan 2020 12:22:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13241AD2C;
        Tue,  7 Jan 2020 17:22:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 798A31E06E5; Tue,  7 Jan 2020 18:22:36 +0100 (CET)
Date:   Tue, 7 Jan 2020 18:22:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Ritesh Harjani <riteshh@linux.ibm.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        joseph.qi@linux.alibaba.com, Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: Discussion: is it time to remove dioread_nolock?
Message-ID: <20200107172236.GJ25547@quack2.suse.cz>
References: <20191226153118.GA17237@mit.edu>
 <9042a8f4-985a-fc83-c059-241c9440200c@linux.alibaba.com>
 <20200106122457.A10F7AE053@d06av26.portsmouth.uk.ibm.com>
 <20200107004338.GB125832@mit.edu>
 <20200107082212.GA25547@quack2.suse.cz>
 <20200107171109.GB3619@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107171109.GB3619@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 07-01-20 12:11:09, Theodore Y. Ts'o wrote:
> Hmm..... There's actually an even more radical option we could use,
> given that Ritesh has made dioread_nolock work on block sizes < page
> size.  We could make dioread_nolock the default, until we can revamp
> ext4_writepages() to write the data blocks first....

Yes, that's a good point. And I'm not opposed to that if it makes the life
simpler. But I'd like to see some performance numbers showing how much is
writeback using unwritten extents slower so that we don't introduce too big
regression with this...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
