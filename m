Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88E3530AF
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 23:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhDBVWh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Apr 2021 17:22:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39626 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229722AbhDBVWh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 17:22:37 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 132LMXuT026518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Apr 2021 17:22:33 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 06A9915C3ACE; Fri,  2 Apr 2021 17:22:32 -0400 (EDT)
Date:   Fri, 2 Apr 2021 17:22:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Milan Djurovic <mdjurovic@zohomail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: dir: Remove unnecessary braces
Message-ID: <YGeLGDfqpz+3ti6M@mit.edu>
References: <20210316052953.67616-1-mdjurovic@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316052953.67616-1-mdjurovic@zohomail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 15, 2021 at 10:29:53PM -0700, Milan Djurovic wrote:
> Removes braces to follow the coding style.
> 
> Signed-off-by: Milan Djurovic <mdjurovic@zohomail.com>

Thanks, applied.

					- Ted
