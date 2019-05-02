Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39832112C6
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2019 07:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfEBFvZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 May 2019 01:51:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbfEBFvZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 May 2019 01:51:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x425gW21031066
        for <linux-ext4@vger.kernel.org>; Thu, 2 May 2019 01:51:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7s13b58m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 02 May 2019 01:51:23 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <chandan@linux.ibm.com>;
        Thu, 2 May 2019 06:51:21 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 06:51:09 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x425p8bL31654042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 05:51:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8459152050;
        Thu,  2 May 2019 05:51:08 +0000 (GMT)
Received: from dhcp-9-193-88-253.localnet (unknown [9.193.88.253])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 61ECB5204F;
        Thu,  2 May 2019 05:51:06 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
        hch@infradead.org, linux-fscrypt@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH V2 10/13] fscrypt_encrypt_page: Loop across all blocks mapped by a page range
Date:   Thu, 02 May 2019 11:22:05 +0530
Organization: IBM
In-Reply-To: <20190501222859.GA127264@gmail.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com> <4666731.7CFakFE75r@localhost.localdomain> <20190501222859.GA127264@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19050205-0020-0000-0000-0000033869D1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050205-0021-0000-0000-0000218AEFBE
Message-Id: <11064745.d7X6JK8F7Z@dhcp-9-193-88-253>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=10 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020045
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thursday, May 2, 2019 3:59:01 AM IST Eric Biggers wrote:
> Hi Chandan,
> 
> On Wed, May 01, 2019 at 08:19:35PM +0530, Chandan Rajendra wrote:
> > On Wednesday, May 1, 2019 4:38:41 AM IST Eric Biggers wrote:
> > > On Tue, Apr 30, 2019 at 10:11:35AM -0700, Eric Biggers wrote:
> > > > On Sun, Apr 28, 2019 at 10:01:18AM +0530, Chandan Rajendra wrote:
> > > > > For subpage-sized blocks, this commit now encrypts all blocks mapped by
> > > > > a page range.
> > > > > 
> > > > > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > > > > ---
> > > > >  fs/crypto/crypto.c | 37 +++++++++++++++++++++++++------------
> > > > >  1 file changed, 25 insertions(+), 12 deletions(-)
> > > > > 
> > > > > diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> > > > > index 4f0d832cae71..2d65b431563f 100644
> > > > > --- a/fs/crypto/crypto.c
> > > > > +++ b/fs/crypto/crypto.c
> > > > > @@ -242,18 +242,26 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
> > > > 
> > > > Need to update the function comment to clearly explain what this function
> > > > actually does now.
> > > > 
> > > > >  {
> > > > >  	struct fscrypt_ctx *ctx;
> > > > >  	struct page *ciphertext_page = page;
> > > > > +	int i, page_nr_blks;
> > > > >  	int err;
> > > > >  
> > > > >  	BUG_ON(len % FS_CRYPTO_BLOCK_SIZE != 0);
> > > > >  
> > > > 
> > > > Make a 'blocksize' variable so you don't have to keep calling i_blocksize().
> > > > 
> > > > Also, you need to check whether 'len' and 'offs' are filesystem-block-aligned,
> > > > since the code now assumes it.
> > > > 
> > > > 	const unsigned int blocksize = i_blocksize(inode);
> > > > 
> > > >         if (!IS_ALIGNED(len | offs, blocksize))
> > > >                 return -EINVAL;
> > > > 
> > > > However, did you check whether that's always true for ubifs?  It looks like it
> > > > may expect to encrypt a prefix of a block, that is only padded to the next
> > > > 16-byte boundary.
> > > > 		
> > > > > +	page_nr_blks = len >> inode->i_blkbits;
> > > > > +
> > > > >  	if (inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES) {
> > > > >  		/* with inplace-encryption we just encrypt the page */
> > > > > -		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num, page,
> > > > > -					     ciphertext_page, len, offs,
> > > > > -					     gfp_flags);
> > > > > -		if (err)
> > > > > -			return ERR_PTR(err);
> > > > > -
> > > > > +		for (i = 0; i < page_nr_blks; i++) {
> > > > > +			err = fscrypt_do_page_crypto(inode, FS_ENCRYPT,
> > > > > +						lblk_num, page,
> > > > > +						ciphertext_page,
> > > > > +						i_blocksize(inode), offs,
> > > > > +						gfp_flags);
> > > > > +			if (err)
> > > > > +				return ERR_PTR(err);
> > > 
> > > Apparently ubifs does encrypt data shorter than the filesystem block size, so
> > > this part is wrong.
> > > 
> > > I suggest we split this into two functions, fscrypt_encrypt_block_inplace() and
> > > fscrypt_encrypt_blocks(), so that it's conceptually simpler what each function
> > > does.  Currently this works completely differently depending on whether the
> > > filesystem set FS_CFLG_OWN_PAGES in its fscrypt_operations, which is weird.
> > > 
> > > I also noticed that using fscrypt_ctx for writes seems to be unnecessary.
> > > AFAICS, page_private(bounce_page) could point directly to the pagecache page.
> > > That would simplify things a lot, especially since then fscrypt_ctx could be
> > > removed entirely after you convert reads to use read_callbacks_ctx.
> > > 
> > > IMO, these would be worthwhile cleanups for fscrypt by themselves, without
> > > waiting for the read_callbacks stuff to be finalized.  Finalizing the
> > > read_callbacks stuff will probably require reaching a consensus about how they
> > > should work with future filesystem features like fsverity and compression.
> > > 
> > > So to move things forward, I'm considering sending out a series with the above
> > > cleanups for fscrypt, plus the equivalent of your patches:
> > > 
> > > 	"fscrypt_encrypt_page: Loop across all blocks mapped by a page range"
> > > 	"fscrypt_zeroout_range: Encrypt all zeroed out blocks of a page"
> > > 	"Add decryption support for sub-pagesized blocks" (fs/crypto/ part only)
> > > 
> > > Then hopefully we can get all that applied for 5.3 so that fs/crypto/ itself is
> > > ready for blocksize != PAGE_SIZE; and get your changes to ext4_bio_write_page(),
> > > __ext4_block_zero_page_range(), and ext4_block_write_begin() applied too, so
> > > that ext4 is partially ready for encryption with blocksize != PAGE_SIZE.
> > > 
> > > Then only the read_callbacks stuff will remain, to get encryption support into
> > > fs/mpage.c and fs/buffer.c.  Do you think that's a good plan?
> > 
> > Hi Eric,
> > 
> > IMHO, I will continue posting the next version of the current patchset and if
> > there are no serious reservations from FS maintainers the "read callbacks"
> > patchset can be merged. In such a scenario, the cleanups being
> > non-complicated, can be merged later.
> > 
> 
> Most of the patches I have in mind are actually things that are in your patchset
> already, or have been requested, or will be requested eventually :-).  I'm
> concerned that people will keep going back and forth on this patchset for a lot
> longer, arguing about fsverity, compression, details of the fs/crypto/ stuff,
> etc.  Moreover it's based on unmerged patches that add the fsverity feature, so
> it can't be merged as-is anyway.
> 
> IMO, it's also difficult for people to review the read_callbacks stuff when it's
> mixed in with lots of other fscrypt and ext4 changes for blocksize != PAGE_SIZE.
> 
> I actually have a patchset almost ready already, so I'm going to send it out and
> see what you think.  It *should* make things a lot easier for you, since then
> you can base a much smaller read_callbacks patchset on top of it.

One of the things that I am concerned most about is the fact that the more we
delay merging read_callbacks patchset, the more the chances of filesystems
adding further operations that get executed after read I/O completes. Most of
the time, these implementations tend to have filesystem specific changes which
are going to be very difficult (impossible?) to make them work with
read_callback patchset. So instead of making things easier, delaying merging
the read_callback patchset ends up actually having the opposite effect.

With the read_callback patchset merged, FS feature developers will take
read_callback framework into consideration before designing/implementing new
related features.

-- 
chandan



