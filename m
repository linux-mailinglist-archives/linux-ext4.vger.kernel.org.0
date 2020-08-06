Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA68A23DBAE
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 18:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHFQ3z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 12:29:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40428 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727985AbgHFQ2r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 12:28:47 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 076EjXDt003609
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 10:45:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B1C72420263; Thu,  6 Aug 2020 10:45:33 -0400 (EDT)
Date:   Thu, 6 Aug 2020 10:45:33 -0400
From:   tytso@mit.edu
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: export msg_count and warning_count via sysfs
Message-ID: <20200806144533.GP7657@mit.edu>
References: <20200725123313.4467-1-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725123313.4467-1-dmtrmonakhov@yandex-team.ru>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jul 25, 2020 at 12:33:13PM +0000, Dmitry Monakhov wrote:
> This numbers can be analized by system automation similar to errors_count.
> In ideal world it would be nice to have separate counters for different
> log-levels, but this makes this patch too intrusive.
> 
> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

Applied, thanks.

						- Ted
