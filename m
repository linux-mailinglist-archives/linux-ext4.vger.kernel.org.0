Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7A82B6E55
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Nov 2020 20:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKQTT1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Nov 2020 14:19:27 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46639 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725771AbgKQTT1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Nov 2020 14:19:27 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AHJJJH6009063
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 14:19:19 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 04E1E420107; Tue, 17 Nov 2020 14:19:18 -0500 (EST)
Date:   Tue, 17 Nov 2020 14:19:18 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>,
        Theodore Tso <tytso@google.com>
Subject: Re: [PATCH] libfs: Fix DIO mode aligment
Message-ID: <20201117191918.GB529216@mit.edu>
References: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
 <19A3D721-93C0-42F3-ACBA-DE15B4685F9F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19A3D721-93C0-42F3-ACBA-DE15B4685F9F@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 17, 2020 at 06:30:11PM +0300, Благодаренко Артём wrote:
> Hello,
> 
> Any thoughts about this change? Thanks.

I'm trying to think of situations where this could actually trigger in
real life.  The only one I can think of is if a file system with a 1k
block file system is located on an an Advanced FormatDrive with a 4k
sector size.

What was the use case where this was actually an issue?

     	     	      	    	     - Ted
