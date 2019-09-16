Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F33B381B
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 12:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfIPKeC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 06:34:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfIPKeB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 06:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0zriILmKCDGiikF7Oyn0qe09shDqYGPmrGUDW/y4opg=; b=S5RsoMbgYcp2ozJ24vD9vcYvg
        3+waoNpeH7BdOwTZ9mQDwhqeRrL+u1yfQqcrYQX0AiE/o7ExBE5G6AUCLHNxsORb67Es/nqekoO5T
        PpgBZ6Iq5p9gt5Jp/HreSVJHu6sHhJGjJldEJ4Kh2MiaYVaURe7jJM943cQKct3wRsipICdc8yLA9
        0rZwUOVWuW/v96V9i0xfVeh6v61bBpYZl/XfXpxB/8vYe9bESSI4J+n5lWxXTS+V7kUepU22DrON/
        +LcV+XAIUbB6y9UM12b26731Dae8/BvvXcQ9iSEo9zYvR3QPLxJLfR5IyWM2ZurzeZnSO4UxqfFn/
        wFhlZ7E4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9oKN-00040J-Nw; Mon, 16 Sep 2019 10:33:51 +0000
Date:   Mon, 16 Sep 2019 03:33:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, zhangjs <zachary@baishancloud.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916103351.GA14308@infradead.org>
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc>
 <20190910115635.GB2740@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910115635.GB2740@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 10, 2019 at 07:56:35AM -0400, Theodore Y. Ts'o wrote:
> Hmm, I'm not seeing this on a Dell XPS 13 (model 9380) using a Debian
> Bullseye (Testing) running a rc4+ kernel.
> 
> This could be because Debian is simply doing more I/O; or it could be
> because I don't have some package installed which is trying to reading
> from /dev/random or calling getrandom(2).  Previously, Fedora ran into
> blocking issues because of some FIPS compliance patches to some
> userspace daemons.  So it's going to be very user space dependent and
> package dependent.

Btw, I've been seeing this issue on debian testing with an XFS root
file system ever since the blocking random changes went in.  There
are a few reports (not from me) in the BTS since.  I ended up just
giving up on gdm and using lightdm instead as it was clearly related
to that.
