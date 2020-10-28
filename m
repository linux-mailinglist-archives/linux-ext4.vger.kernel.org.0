Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDDD29D79D
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Oct 2020 23:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbgJ1WYp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 18:24:45 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44474 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732941AbgJ1WY0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Oct 2020 18:24:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SMJFPM172285;
        Wed, 28 Oct 2020 22:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9z10xMVcuhTeCp1KBESvCxRUUhDSAblD5Dwcu8HA9ec=;
 b=mXIIOKjSezussF3BeD1gp1G+O/SEgu6uz2/dwynYj9ncwaSv8Is8EnoZfiub8i7rX1s1
 7bAxgbUxejQp70aWJthwyuMiEu0IknJQAzTBOQhDY7mQr4HLzjBYihqQESP+PuFceNew
 mhGuu0EFHyyQqSJL/iEj24JvETHtJr4q+E9Bdfxta0CIl3G7lzbCf7vK9mFXXyqL/HO6
 jCgwBhzcu9bKgIz7XYW/krCkBBBFRcsonn9AFWRGCxzb1xmui+/c70qrty7s6ehFHshY
 RvgUjYID0EheJlwBtzjfecw5VrrqkfcDC1muiQBaYKq1hjbhGe4B3xgE+rwSh+SJ9mH0 Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34c9sb25xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 22:24:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SMKLah180153;
        Wed, 28 Oct 2020 22:24:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34cx1shev4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 22:24:13 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09SMODvk001220;
        Wed, 28 Oct 2020 22:24:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 15:24:12 -0700
Date:   Wed, 28 Oct 2020 15:24:11 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     guaneryu@gmail.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/9] common: extract rt extent size for
 _get_file_block_size
Message-ID: <20201028222411.GE1061252@magnolia>
References: <160382528936.1202316.2338876126552815991.stgit@magnolia>
 <160382529579.1202316.931742119756545034.stgit@magnolia>
 <20201028074119.GA2750@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028074119.GA2750@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280137
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 28, 2020 at 07:41:19AM +0000, Christoph Hellwig wrote:
> On Tue, Oct 27, 2020 at 12:01:35PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > _get_file_block_size is intended to return the size (in bytes) of the
> > fundamental allocation unit for a file.  This is required for remapping
> > operations like fallocate and reflink, which can only operate on
> > allocation units.  Since the XFS realtime volume can be configure for
> > allocation units larger than 1 fs block, we need to factor that in here.
> 
> Should this also cover the ext4 bigalloc clusters?  Or do they not
> matter for fallocate?

They don't matter for fallocate, because ext4 doesn't require clusters
to be fully allocated like ocfs2 and xfs do.

This means that all the bigalloc codepaths have this horrible "implied
cluster allocation" thing sprinkled everywhere where to map in a single
block you have to scan left and right in the extent map to see if anyone
already mapped something.  And even more strangely, extent tree blocks
don't do this, so it seems to waste the entire cluster past the first fs
block.

But I guess it /does/ mean that _get_file_block_size doesn't have to do
anything special for ext*.

--D

> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  common/rc  |   13 ++++++++++---
> >  common/xfs |   20 ++++++++++++++++++++
> >  2 files changed, 30 insertions(+), 3 deletions(-)
> > 
> > 
> > diff --git a/common/rc b/common/rc
> > index 27a27ea3..41f93047 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3974,11 +3974,18 @@ _get_file_block_size()
> >  		echo "Missing mount point argument for _get_file_block_size"
> >  		exit 1
> >  	fi
> > -	if [ "$FSTYP" = "ocfs2" ]; then
> > +
> > +	case "$FSTYP" in
> > +	"ocfs2")
> >  		stat -c '%o' $1
> > -	else
> > +		;;
> > +	"xfs")
> > +		_xfs_get_file_block_size $1
> > +		;;
> > +	*)
> >  		_get_block_size $1
> > -	fi
> > +		;;
> > +	esac
> >  }
> >  
> >  # Get the minimum block size of an fs.
> > diff --git a/common/xfs b/common/xfs
> > index 79dab058..3f5c14ba 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -174,6 +174,26 @@ _scratch_mkfs_xfs()
> >  	return $mkfs_status
> >  }
> >  
> > +# Get the size of an allocation unit of a file.  Normally this is just the
> > +# block size of the file, but for realtime files, this is the realtime extent
> > +# size.
> > +_xfs_get_file_block_size()
> > +{
> > +	local path="$1"
> > +
> > +	if ! ($XFS_IO_PROG -c "stat -v" "$path" 2>&1 | egrep -q '(rt-inherit|realtime)'); then
> > +		_get_block_size "$path"
> > +		return
> > +	fi
> > +
> > +	# Otherwise, call xfs_info until we find a mount point or the root.
> > +	path="$(readlink -m "$path")"
> > +	while ! $XFS_INFO_PROG "$path" &>/dev/null && [ "$path" != "/" ]; do
> > +		path="$(dirname "$path")"
> > +	done
> > +	$XFS_INFO_PROG "$path" | grep realtime | sed -e 's/^.*extsz=\([0-9]*\).*$/\1/g'
> > +}
> > +
> >  # xfs_check script is planned to be deprecated. But, we want to
> >  # be able to invoke "xfs_check" behavior in xfstests in order to
> >  # maintain the current verification levels.
> > 
> ---end quoted text---
