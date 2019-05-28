Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEBFA2C7B5
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 15:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfE1NXd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 May 2019 09:23:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49784 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726924AbfE1NXd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 May 2019 09:23:33 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4SDNRUl004130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 09:23:28 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8A8C1420481; Tue, 28 May 2019 09:23:27 -0400 (EDT)
Date:   Tue, 28 May 2019 09:23:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [bugreport] kernel 5.2 pblk bad header/extent: invalid extent
 entries
Message-ID: <20190528132327.GC19149@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
References: <CABXGCsNPMSQgBjnFarYaxuQEGpA1G=U4U9OHqT0E53pNL2BK8g@mail.gmail.com>
 <CABXGCsNV6EQq0EG=iO8mWCCv9da__9iyLmwyzS3nGtjjvhShfg@mail.gmail.com>
 <CABXGCsNvYVL6SMO_0PXxiZwWJyBi3rD-jjxnmnY3KL0M7haJbA@mail.gmail.com>
 <CABXGCsOvTyL5W1qm0DzTuS4juo6ya+XSxMESGsP2RqtSSzpdfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsOvTyL5W1qm0DzTuS4juo6ya+XSxMESGsP2RqtSSzpdfg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 28, 2019 at 10:58:03AM +0500, Mikhail Gavrilov wrote:
> On Mon, 27 May 2019 at 21:16, Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > I am bisected issue. I hope it help understand what is happened on my computer.
> >
> 
> Why no one answers?
> Even if the problem is known and already fixed, I would be nice to
> know that I spent 10 days for searching a problem commit not in vain
> and someone reads my messages.

Sorry, I didn't see your earlier messages; I'm not sure why.  In any
case, yes, it's a known issue, and it's fixed in 5.2-rc2.  This fix
was commit 0a944e8a6c66.

						- Ted

