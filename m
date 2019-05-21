Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EBC25750
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2019 20:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfEUSNA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 May 2019 14:13:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:32849 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbfEUSNA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 May 2019 14:13:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 11:12:58 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2019 11:12:58 -0700
Date:   Tue, 21 May 2019 11:13:49 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] ext4: Do not delete unlinked inode from orphan list
 on failed truncate
Message-ID: <20190521181348.GB31888@iweiny-DESK2.sc.intel.com>
References: <20190521074358.17186-1-jack@suse.cz>
 <20190521074358.17186-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521074358.17186-3-jack@suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 21, 2019 at 09:43:57AM +0200, Jan Kara wrote:
> It is possible that unlinked inode enters ext4_setattr() (e.g. if
> somebody calls ftruncate(2) on unlinked but still open file). In such
> case we should not delete the inode from the orphan list if truncate
> fails. Note that this is mostly a theoretical concern as filesystem is
> corrupted if we reach this path anyway but let's be consistent in our
> orphan handling.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 9bcb7f2b86dd..c7f77c643008 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5625,7 +5625,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
>  			up_write(&EXT4_I(inode)->i_data_sem);
>  			ext4_journal_stop(handle);
>  			if (error) {
> -				if (orphan)
> +				if (orphan && inode->i_nlink)
>  					ext4_orphan_del(NULL, inode);


NIT: While ext4_orphan_del() can be called even if the inode was not on the
orphan list it kind of tripped me up to see this called even if
ext4_orphan_add() fails...

But considering how ext4_orphan_del() works:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>  				goto err_out;
>  			}
> -- 
> 2.16.4
> 
