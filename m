Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA563A9E31
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 16:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhFPOzk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 10:55:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40244 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233775AbhFPOzj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 10:55:39 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15GErQmd018668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:53:27 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 94ECB15C3CB8; Wed, 16 Jun 2021 10:53:26 -0400 (EDT)
Date:   Wed, 16 Jun 2021 10:53:26 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] docs: filesystems: ext4: blockgroup.rst: replace
 some characters
Message-ID: <YMoQZmY2x7QDpxi6@mit.edu>
References: <cover.1623826294.git.mchehab+huawei@kernel.org>
 <c5c3c384c48779ca7c9dcd90183cefe20ac82928.1623826294.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5c3c384c48779ca7c9dcd90183cefe20ac82928.1623826294.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 16, 2021 at 08:55:12AM +0200, Mauro Carvalho Chehab wrote:
> The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
> conversion and some cut-and-pasted text contain some characters that
> aren't easily reachable on standard keyboards and/or could cause
> troubles when parsed by the documentation build system.
> 
> Replace the occurences of the following characters:
> 
> 	- U+2217 ('∗'): ASTERISK OPERATOR
> 	  use ASCII asterisk instead of the ASTERISK OPERATOR
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
