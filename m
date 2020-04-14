Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747211A715B
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Apr 2020 04:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404338AbgDNC7S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Apr 2020 22:59:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50475 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404336AbgDNC7S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Apr 2020 22:59:18 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03E2xFuh014642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 22:59:15 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D5EEA42013D; Mon, 13 Apr 2020 22:59:14 -0400 (EDT)
Date:   Mon, 13 Apr 2020 22:59:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: fix BUG_ON in
 fs/ext4/page_io.c:ext4_release_io_end()
Message-ID: <20200414025914.GE90651@mit.edu>
References: <20200414022842.272657-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414022842.272657-1-tytso@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 13, 2020 at 10:28:42PM -0400, Theodore Ts'o wrote:
> The function ext4_release_io_end() can be called by
> ext4_put_io_end_defer() with the EXT4_IO_UNWRITTEN flag set and
> io_end->size is 0.  In that case, it's safe to release the io_end
> structure, since if io_end->size is zero, there is no unwritten region
> to release.
> 
> This can be reproduced using generic/300, although not very reliably,
> and almost never using a freshly rebooted kernel.
> 
> Google-Bug-Id: 15054006
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

NACK; this patch no longer applies given the move to use iomap for direct I/O.

      	   	    	   	   	 - Ted
