Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F086ED815
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 04:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfKDDdA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Nov 2019 22:33:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56515 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728762AbfKDDdA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Nov 2019 22:33:00 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA43WslA009555
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Nov 2019 22:32:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 16364420311; Sun,  3 Nov 2019 22:32:52 -0500 (EST)
Date:   Sun, 3 Nov 2019 22:32:52 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/19 v3] ext4: Fix transaction overflow due to revoke
 descriptors
Message-ID: <20191104033252.GC12046@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

I believe that I'm waiting for the v4 version of this series with some
pending fixes that you are planning on making.  Is that correct?

Thanks!!

					- Ted
