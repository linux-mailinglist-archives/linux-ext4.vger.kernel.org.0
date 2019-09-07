Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B117EACBAF
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Sep 2019 10:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfIHIw1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Sep 2019 04:52:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36718 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727497AbfIHIw1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Sep 2019 04:52:27 -0400
Received: from callcc.thunk.org (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x888qH5V025743
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Sep 2019 04:52:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 31D9042049E; Sat,  7 Sep 2019 11:57:47 -0400 (EDT)
Date:   Sat, 7 Sep 2019 11:57:47 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ayush Ranjan <ayush.ranjan98@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Ext4 Docs: Add missing bigalloc documentation.
Message-ID: <20190907155747.GA23683@mit.edu>
References: <20190831154419.GA30357@fa19-cs241-404.cs.illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831154419.GA30357@fa19-cs241-404.cs.illinois.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Aug 31, 2019 at 10:44:19AM -0500, Ayush Ranjan wrote:
> There was a broken link for bigalloc. The page
> https://ext4.wiki.kernel.org/index.php/Bigalloc was not migrated into
> the current documentation sources. This patch adds the contents of that
> missing page into the section for Bigalloc itself.
> 
> Signed-off-by: Ayush Ranjan <ayushr2@illinois.edu>

Thanks, applied.

					- Ted
