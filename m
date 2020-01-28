Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8369114C29E
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2020 23:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA1WLN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jan 2020 17:11:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgA1WLN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Jan 2020 17:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8Cietpdt2xmaFbSAlPx9LpdRoHx96sBla0A8W1je4jI=; b=QX9Rx2MFcuMVT+6MxhZZldreRH
        i2I8dGxPxsLPw7cLGtYDlwFX/lIwFgzBvkwhMpBqOdgFFYnJw8GAyv518zwiqduqqA6Hc6bzZ/LIt
        2wPlyhvi2mQn+t50X2xpxFHFueR0Za6n6a9Dl2R09wgn0E7wagn0JWsNTTmknjpOmG3GBf+GKfWQa
        8gKH8Qaw4DIJFIiN8U3oP6J+ZujtJuAduygwUFEqMFg0nAAklKGZ6Pqr+OMQh4IEbEEOwnM2cQ9+g
        XaSY2A3/aOrC3rLdqYffOzpIu2tfCT+Rflbm7C9EWaCS9K+SAOWAiHq++IN+h7N8AgzqPZJhgGA80
        Hhq969gw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwZ4i-0000fy-RL; Tue, 28 Jan 2020 22:11:12 +0000
Date:   Tue, 28 Jan 2020 14:11:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [willy@infradead.org: Re: [willy@infradead.org: Re: [PATCH v4] fs:
 introduce is_dot_or_dotdot helper for cleanup]]
Message-ID: <20200128221112.GA30200@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


I've tried to get Ted's opinion on this a few times with radio silence.
Or email is broken.  Anyone else care to offer an opinion?

----- Forwarded message from Matthew Wilcox <willy@infradead.org> -----

Date: Thu, 23 Jan 2020 21:11:43 -0800
From: Matthew Wilcox <willy@infradead.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [willy@infradead.org: Re: [PATCH v4] fs: introduce
	is_dot_or_dotdot helper for cleanup]


ping?

On Mon, Dec 30, 2019 at 06:13:03AM -0800, Matthew Wilcox wrote:
> 
> Didn't see a response from you on this.  Can you confirm the three
> cases in ext4 mentioned below should be converted to return -EUNCLEAN?
> 
> ----- Forwarded message from Matthew Wilcox <willy@infradead.org> -----
> 
> Date: Thu, 12 Dec 2019 10:13:02 -0800
> From: Matthew Wilcox <willy@infradead.org>
> To: Eric Biggers <ebiggers@kernel.org>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexander Viro
> 	<viro@zeniv.linux.org.uk>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk
> 	Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Tyler Hicks
> 	<tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org,
> 	ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
> 	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
> User-Agent: Mutt/1.12.1 (2019-06-15)
> 
> On Tue, Dec 10, 2019 at 11:19:13AM -0800, Eric Biggers wrote:
> > > +static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> > > +{
> > > +	if (unlikely(name[0] == '.')) {
> > > +		if (len < 2 || (len == 2 && name[1] == '.'))
> > > +			return true;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > 
> > This doesn't handle the len=0 case.  Did you check that none of the users pass
> > in zero-length names?  It looks like fscrypt_fname_disk_to_usr() can, if the
> > directory entry on-disk has a zero-length name.  Currently it will return
> > -EUCLEAN in that case, but with this patch it may think it's the name ".".
> 
> Trying to wrench this back on track ...
> 
> fscrypt_fname_disk_to_usr is called by:
> 
> fscrypt_get_symlink():
>        if (cstr.len == 0)
>                 return ERR_PTR(-EUCLEAN);
> ext4_readdir():
> 	Does not currently check de->name_len.  I believe this check should
> 	be added to __ext4_check_dir_entry() because a zero-length directory
> 	entry can affect both encrypted and non-encrypted directory entries.
> dx_show_leaf():
> 	Same as ext4_readdir().  Should probably call ext4_check_dir_entry()?
> htree_dirblock_to_tree():
> 	Would be covered by a fix to ext4_check_dir_entry().
> f2fs_fill_dentries():
> 	if (de->name_len == 0) {
> 		...
> ubifs_readdir():
> 	Does not currently check de->name_len.  Also affects non-encrypted
> 	directory entries.
> 
> So of the six callers, two of them already check the dirent length for
> being zero, and four of them ought to anyway, but don't.  I think they
> should be fixed, but clearly we don't historically check for this kind
> of data corruption (strangely), so I don't think that's a reason to hold
> up this patch until the individual filesystems are fixed.
> 
> ----- End forwarded message -----

----- End forwarded message -----
