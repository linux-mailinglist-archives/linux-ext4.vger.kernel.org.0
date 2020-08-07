Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB71223EF27
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHGOmH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 10:42:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33043 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbgHGOmH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 10:42:07 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 077EfsH8026551
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Aug 2020 10:41:55 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A7E0A420263; Fri,  7 Aug 2020 10:41:54 -0400 (EDT)
Date:   Fri, 7 Aug 2020 10:41:54 -0400
From:   tytso@mit.edu
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org, guan@eryu.me, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4/002: Test read-only external journal device
Message-ID: <20200807144154.GU7657@mit.edu>
References: <20200717105544.3201-1-lczerner@redhat.com>
 <20200727102618.11695-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727102618.11695-1-lczerner@redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 27, 2020 at 12:26:18PM +0200, Lukas Czerner wrote:
> We should never be able to mount ext4 file system read-write with
> read-only external journal device. Test it.
> 
> This problem has been addressed with proposed kernel patch
> https://lore.kernel.org/linux-ext4/20200717090605.2612-1-lczerner@redhat.com/
> 
> The test was based on generic/050.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Looks good, tested with and without the fix.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
