Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72F123D63D
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 07:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgHFFDT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 01:03:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45517 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725271AbgHFFDR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 01:03:17 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0765355t023378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 01:03:06 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C7274420263; Thu,  6 Aug 2020 01:03:05 -0400 (EDT)
Date:   Thu, 6 Aug 2020 01:03:05 -0400
From:   tytso@mit.edu
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     adilger.kernel@dilger.ca, corbet@lwn.net,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Ext4
Message-ID: <20200806050305.GF7657@mit.edu>
References: <20200706190339.20709-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706190339.20709-1-grandmaster@al2klimov.de>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 06, 2020 at 09:03:39PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.

Thanks, applied.

						- Ted
