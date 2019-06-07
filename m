Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88663919D
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jun 2019 18:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfFGQI5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jun 2019 12:08:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39818 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfFGQI5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jun 2019 12:08:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so1003021plm.6;
        Fri, 07 Jun 2019 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UTRlaeqGZ/EWHmpBdkbTHgcWrizXvp7se22JNxvyE8A=;
        b=KtH5jN5gCmApeRqKkYD60anUf1/8Y2zrDzRrWz8CGCv7hRplpCutUtRYWwoe2OCZJy
         AomUQ806VJmxZwWuG9X5S9URxkq/pkTbqCBMjvmyJCgmP85QUusZ52zlpMAX981zlJGr
         rly2BTGzB1UCfRWZOh5PLAfHBmqHrS1USUa/fwWOQPSAerYBBGxDM2/kJtXmdqpsEDDd
         04jq9/38sW3++pqdWcAUFe4PFmvo8BDY84IiLkK3L9mToqm8UqjJ/r/jJxAuCA7y2zl1
         ultjxgsQMEYhzkHjoUCiXA0RY5Q+XkZ8xKoeCBW0rG/1jnS1j4XnAFGl4kNM0jTL/9iU
         /rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UTRlaeqGZ/EWHmpBdkbTHgcWrizXvp7se22JNxvyE8A=;
        b=YnE4i1tHCoAdUX5iu5RWEZCUZzXJpbgpSGBiQcll09aIrTyBMgfkGRi+gPDfHxBWjz
         H4v+1BVSBdfTH166RuT/x8LkjG3ndHLzBUrgf5iVlIjKPR2Qo8CH9RhOGpfaF/bIPfry
         LEJBmKJ/UVgoWmiTG7tOqMEG+D5chEGxuX2SAmfdQxloi7AEb135oh+UKOQtMJp5ryFH
         pHKRvfj00jYN+qFkWD+PimkTLtLNUNMsm2MwdISmtBWDGVwX4kaK0TxTqYIdCW73xie6
         46EFMxFUWGXf3iOIOEnebu0rdPHs8rA95K/aycVDuE1rwgrxoqGa1e7aNrUeqNH3L6bJ
         ubmA==
X-Gm-Message-State: APjAAAUPoN33tTByWNz0GkYvTLMdryUGBoCSx40giWal3IHyGKP3kNFU
        BEQ2emqziTKV2bFFrTAthSU=
X-Google-Smtp-Source: APXvYqyHfe4JS/gaHKKu4p4jQdbZwDE50KBnm3XQ7MoLLy/QgQHxtYakoxqFHRKczX+e9q0+ZY3CCg==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3mr34252723plr.74.1559923735913;
        Fri, 07 Jun 2019 09:08:55 -0700 (PDT)
Received: from localhost ([47.254.35.144])
        by smtp.gmail.com with ESMTPSA id j20sm2903473pff.183.2019.06.07.09.08.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 09:08:55 -0700 (PDT)
Date:   Sat, 8 Jun 2019 00:08:52 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/2] common/casefold: Add infrastructure to test
 filename casefold feature
Message-ID: <20190607160852.GU15846@desktop>
References: <20190606193138.25852-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606193138.25852-1-krisman@collabora.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 06, 2019 at 03:31:37PM -0400, Gabriel Krisman Bertazi wrote:
> Add a set of basic helper functions to simplify the testing of
> casefolding capable filesystems.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  common/casefold | 108 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 common/casefold
> 
> diff --git a/common/casefold b/common/casefold
> new file mode 100644
> index 000000000000..34c1d4ae1af1
> --- /dev/null
> +++ b/common/casefold
> @@ -0,0 +1,108 @@
> +#-----------------------------------------------------------------------
> +#
> +# Common functions for testing filename casefold feature
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2018 Collabora, Ltd.  All Rights Reserved.
                   ^^^^ 2019?
> +#
> +# Author: Gabriel Krisman Bertazi <krisman@collabora.com>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------

Please use the SPDX tags to specify licence, you could take common/rc as
a reference.

> +
> +_has_casefold_feature_kernel_support() {

The name seems a bit long to me, just _has_casefold_kernel_support()?

> +    case $FSTYP in
> +	ext4)
> +	    test -f '/sys/fs/ext4/features/casefold'
> +	    ;;
> +	*)
> +	    # defaults to unsupported
> +	    false
> +	    ;;
> +    esac

Please use 8-spaces tab for indention. The same for the new test.

> +}
> +
> +_require_casefold_support() {

_require_scratch_casefold(), as the function test casefold support
against scratch device, so add "scratch" in the function name to
indicate that.

> +    if ! _has_casefold_feature_kernel_support ; then
> +	_notrun "$FSTYP does not support casefold feature"
> +    fi
> +
> +    if ! _scratch_mkfs_casefold &>>seqres.full; then
> +	_notrun "$FSTYP userspace tools do not support casefold"
> +    fi
> +
> +    # Make sure the kernel can mount a filesystem with the encoding
> +    # defined by the userspace tools.  This will fail if
> +    # the userspace tool used a more recent encoding than the one
> +    # supported in kernel space.
> +    if ! _try_scratch_mount &>>seqres.full; then
> +	_notrun \
> +	    "kernel can't mount filesystem using the encoding set by userspace"
> +    fi
> +    _scratch_unmount
> +}
> +
> +_scratch_mkfs_casefold () {
> +    case $FSTYP in
> +	ext4)
> +	    _scratch_mkfs -O casefold $*
> +	    ;;
> +	*)
> +	    _notrun "Don't know how to mkfs with casefold support on $FSTYP"
> +	    ;;
> +	esac
> +}
> +
> +_scratch_mkfs_casefold_strict () {
> +    case $FSTYP in
> +	ext4)
> +	    _scratch_mkfs -O casefold -E encoding_flags=strict
> +	    ;;
> +	*)
> +	    _notrun \
> +		"Don't know how to mkfs with casefold-strict support on $FSTYP"
> +	    ;;
> +	esac
> +}
> +
> +_casefold_check_exact_name () {
> +    # To get the exact disk name, we need some method that does a
> +    # getdents() on the parent directory, such that we don't get
> +    # normalized/casefolded results.  'Find' works ok.

I think these could go before the helper.

> +    basedir=$1
> +    exact_name=$2

Declare local variables as "local", the same for all other local
variables, both in this casefold file and in the new test.

> +    find ${basedir} | grep -q ${exact_name}
> +}
> +
> +_try_set_casefold_attr () {
> +    chattr +F "${1}" &>/dev/null

$CHATTR_PROG

And need to require chattr in _require_scratch_casefold() too, e.g.

	_require_command "$CHATTR_PROG" chattr
> +}
> +
> +_try_unset_casefold_attr () {
> +    chattr -F "${1}" &>/dev/null

Same here. And I don't think we should redirect chattr output in these
helper functions, just let callers handle the outputs.

> +}
> +
> +_set_casefold_attr () {
> +    _try_set_casefold_attr "${1}" || \
> +	_fail "Unable to set casefold attribute on ${1}"
> +}
> +
> +_unset_casefold_attr () {
> +    _try_unset_casefold_attr "${1}" || \
> +	_fail "Unable to unset casefold attribute on ${1}"
> +}

And no need to _fail here. IMHO, just two helpers like:

_set_casefold_attr()
{
	$CHATTR_PROG +F "${1}"
}

_unset_casefold_attr()
{
	$CHATTR_PROG -F "${1}"
}

And let callers deal with the outputs/results. More comments on this in
next patch.

> +
> +_is_casefolded_dir () {
> +    lsattr -ld "${1}" | grep -q "Casefold"
> +}

$LSATTR_PROG, and do 

	_require_command "$LSATTR_PROG" lsattr

in _require_scratch_casefold() as well.

Thanks,
Eryu
> -- 
> 2.20.1
> 
