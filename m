Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23A2ADE7D
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Nov 2020 19:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgKJSiZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Nov 2020 13:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730859AbgKJSiZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Nov 2020 13:38:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338D5C0613D1;
        Tue, 10 Nov 2020 10:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l93VrRujfp95Zc31OkJt16YFqf0i+F4gVSggIc/hd7Q=; b=dkrLW+jyelnVUHGW5tkcS2HnhU
        K2SPkxMOyD+e/mojCh3vVCFwfmKY4jfDnKnR8TfHgm2g93AtXmd1FfXEE9rvRpGo1aVboogs1Sc/U
        o5iUZDOuedCf3dRD8BDRshFrLCiUPQ9eGvj29q0wtk8vRBOqJEYVMJ87Tntz5PloQyAdy3CueQ5/o
        uJqWudWUcYIRkBBQVPaIuSBascDiUNyAVcPMeU4KeOTVjXZ1JX170VjbNNymwaJAR5mI3XrBJXVtC
        ADOSde6Of5NupmaDAF7JL1sjq8XkdCVNzn02KXRNjWjO3FgTxfZcxYkw2j3aaA6uBXmOKjhCInqU2
        c01m+kPg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcYX9-0002kR-Fj; Tue, 10 Nov 2020 18:38:23 +0000
Date:   Tue, 10 Nov 2020 18:38:23 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs: show the dax option in mount options.
Message-ID: <20201110183823.GJ9418@infradead.org>
References: <cover.1604948373.git.msuchanek@suse.de>
 <f9f7ba25e97dacd92c09eb3ee6a4aca8b4f72b00.1604948373.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f7ba25e97dacd92c09eb3ee6a4aca8b4f72b00.1604948373.git.msuchanek@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 09, 2020 at 08:10:08PM +0100, Michal Suchanek wrote:
> xfs accepts both dax and dax_enum but shows only dax_enum. Show both
> options.

Which is very much intentional.  The -o dax was an experimental hack
that fortunately is gone now.
