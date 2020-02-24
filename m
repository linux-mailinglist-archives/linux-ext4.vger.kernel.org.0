Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABEB316B0FB
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2020 21:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgBXUca (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Feb 2020 15:32:30 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41674 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727168AbgBXUca (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Feb 2020 15:32:30 -0500
Received: from callcc.thunk.org ([4.28.11.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01OKWNMK028673
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Feb 2020 15:32:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B9DF94211EF; Mon, 24 Feb 2020 15:32:22 -0500 (EST)
Date:   Mon, 24 Feb 2020 15:32:22 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeremy Visser <jeremyvisser@google.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] chattr.1: improve attribute formatting with labels and
 indented paragraphs
Message-ID: <20200224203222.GA5112@mit.edu>
References: <20200203023741.218441-1-jeremyvisser@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203023741.218441-1-jeremyvisser@google.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 03, 2020 at 01:37:41PM +1100, Jeremy Visser wrote:
> By convention, lists of options in man pages use a label followed by an
> indented description, such as this example from the Options section:
> 
>      -R     Recursively change attributes of directories and
>             their contents.
> 
> But the Attributes section places the available attributes mid-sentence,
> which makes it visually more difficult to parse:
> 
>      A file with the 'a' attribute set can only be opened
>      in append mode for writing.  [...]
> 
>      When a file with the 'A' attribute set is accessed, its
>      atime record is not modified.  [...]
> 
> This patch places a label beside each attribute description, which (in
> my opinion) improves readability, especially when visually skimming the
> list.  For example:
> 
>      a      A file with the 'a' attribute set can only be
>             opened in append mode for writing.
> 
>      A      When a file with the 'A' attribute set is accessed,
>             its atime record is not modified.
> 
> Signed-off-by: Jeremy Visser <jeremyvisser@google.com>

Applied, thanks.

					- Ted
