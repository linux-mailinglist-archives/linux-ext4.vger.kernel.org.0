Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE70F280166
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 16:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbgJAOgy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 10:36:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52770 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726412AbgJAOgy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 10:36:54 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 091EalFt000890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Oct 2020 10:36:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2DBC942003C; Thu,  1 Oct 2020 10:36:47 -0400 (EDT)
Date:   Thu, 1 Oct 2020 10:36:47 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Florian Schmaus <flo@geekplace.eu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] e4crypt: if salt is explicitly provided to add_key,
 then use it
Message-ID: <20201001143647.GI23474@mit.edu>
References: <20200706194727.12979-1-flo@geekplace.eu>
 <20200707082729.85058-1-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707082729.85058-1-flo@geekplace.eu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 07, 2020 at 10:27:30AM +0200, Florian Schmaus wrote:
> Providing -S and a path to 'add_key' previously exhibit an unintuitive
> behavior: instead of using the salt explicitly provided by the user,
> e4crypt would use the salt obtained via EXT4_IOC_GET_ENCRYPTION_PWSALT
> on the path. This was because set_policy() was still called with NULL
> as salt.
> 
> With this change we now remember the explicitly provided salt (if any)
> and use it as argument for set_policy().
> 
> Eventually
> 
> e4crypt add_key -S s:my-spicy-salt /foo
> 
> will now actually use 'my-spicy-salt' and not something else as salt
> for the policy set on /foo.
> 
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>

Applied, with the spell correction Eric pointed out.

	      	  		   	- Ted
