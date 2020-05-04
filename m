Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3605F1C3131
	for <lists+linux-ext4@lfdr.de>; Mon,  4 May 2020 03:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgEDBv1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 May 2020 21:51:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59811 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726377AbgEDBv1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 May 2020 21:51:27 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0441pM0b020436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 May 2020 21:51:23 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B3FD642085D; Sun,  3 May 2020 21:51:22 -0400 (EDT)
Date:   Sun, 3 May 2020 21:51:22 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jonny Grant <jg@jguk.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: /fs/ext4/namei.c ext4_find_dest_de()
Message-ID: <20200504015122.GB404484@mit.edu>
References: <2edc7d6a-289e-57ad-baf1-477dc240474d@jguk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2edc7d6a-289e-57ad-baf1-477dc240474d@jguk.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, May 03, 2020 at 02:00:25PM +0100, Jonny Grant wrote:
> Hi
> 
> I noticed that mkdir() returns EEXIST if a directory already exists.
> strerror(EEXIST) text is "File exists"
> 
> Can ext4_find_dest_de() be amended to return EISDIR if a directory already
> exists? This will make the error message clearer.

No; this will confuse potentially a large number of existing programs.
Also, the current behavior is required by POSIx and the Single Unix
Specification standards.

	https://pubs.opengroup.org/onlinepubs/009695399/

Regards,

						- Ted
