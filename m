Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C1E2DB3E2
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Dec 2020 19:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbgLOSkB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Dec 2020 13:40:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54729 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729716AbgLOSj5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Dec 2020 13:39:57 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BFIcxNR025801
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 13:39:00 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 94EE6420280; Tue, 15 Dec 2020 13:38:59 -0500 (EST)
Date:   Tue, 15 Dec 2020 13:38:59 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2] create_inode: set xattrs to the root directory as well
Message-ID: <X9kCwz0Ok0gnG009@mit.edu>
References: <20200717100846.497546-1-antoine.tenart@bootlin.com>
 <B2EE7AC5-BEC0-46A8-8C37-D3085645F94C@dilger.ca>
 <159609406998.3391.5621985067917886015@kwain>
 <159920782384.787733.9857416604675445355@kwain>
 <E65D3B4E-A8C4-4BC8-9A6C-07E900F90D9A@dilger.ca>
 <159946362909.787733.4975683171769234991@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159946362909.787733.4975683171769234991@kwain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, applied.

And apologies for the delay!

					- Ted
